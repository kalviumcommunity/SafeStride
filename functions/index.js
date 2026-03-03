const {setGlobalOptions} = require("firebase-functions/v2");
const {onCall} = require("firebase-functions/v2/https");
const {onDocumentCreated, onDocumentUpdated} = require("firebase-functions/v2/firestore");
const {onObjectFinalized} = require("firebase-functions/v2/storage");
const {onRequest} = require("firebase-functions/https");
const logger = require("firebase-functions/logger");

// Set global options for cost control
setGlobalOptions({
  maxInstances: 10,
  region: "us-central1",
});

// =========================
// CALLABLE FUNCTIONS
// =========================

/**
 * Welcome message function - Basic callable function
 * Returns a personalized welcome message
 */
exports.sayHello = onCall((request) => {
  const name = request.data.name || "SafeStride User";
  const message = `Hello, ${name}! Welcome to SafeStride - your community-verified route companion!`;

  logger.info(`sayHello called with name: ${name}`);

  return {
    message,
    timestamp: new Date().toISOString(),
    app: "SafeStride",
  };
});

/**
 * Route validation function - Validates route data
 * Checks if route data meets SafeStride requirements
 */
exports.validateRoute = onCall((request) => {
  const routeData = request.data;

  logger.info("Validating route data", { routeData });

  // Validation rules
  const validationRules = {
    name: { required: true, minLength: 3, maxLength: 100 },
    distance: { required: true, min: 0.1, max: 1000 },
    type: { required: true, allowed: ["running", "cycling", "walking"] },
    safetyRating: { required: true, min: 1, max: 5 },
  };

  const errors = [];

  // Validate each field
  Object.keys(validationRules).forEach((field) => {
    const rules = validationRules[field];
    const value = routeData[field];

    if (rules.required && (value === undefined || value === null)) {
      errors.push(`${field} is required`);
      return;
    }

    if (field === "name" && value) {
      if (value.length < rules.minLength) {
        errors.push(`${field} must be at least ${rules.minLength} characters`);
      }
      if (value.length > rules.maxLength) {
        errors.push(`${field} must be less than ${rules.maxLength} characters`);
      }
    }

    if (field === "distance" && value !== undefined) {
      if (value < rules.min || value > rules.max) {
        errors.push(`${field} must be between ${rules.min} and ${rules.max} km`);
      }
    }

    if (field === "type" && value) {
      if (!rules.allowed.includes(value)) {
        errors.push(`${field} must be one of: ${rules.allowed.join(", ")}`);
      }
    }

    if (field === "safetyRating" && value !== undefined) {
      if (value < rules.min || value > rules.max) {
        errors.push(`${field} must be between ${rules.min} and ${rules.max}`);
      }
    }
  });

  const isValid = errors.length === 0;

  return {
    isValid,
    errors,
    validatedAt: new Date().toISOString(),
  };
});

/**
 * Safety score calculation function
 * Calculates safety score based on route factors
 */
exports.calculateSafetyScore = onCall((request) => {
  const { routeType, distance, timeOfDay, weatherConditions } = request.data;

  logger.info("Calculating safety score", { routeType, distance, timeOfDay, weatherConditions });

  let baseScore = 5.0;

  // Adjust based on route type
  if (routeType === "running") baseScore += 0.5;
  if (routeType === "cycling") baseScore -= 0.2;

  // Adjust based on distance (longer routes might be riskier)
  if (distance > 20) baseScore -= 0.3;

  // Adjust based on time of day
  if (timeOfDay === "night") baseScore -= 1.0;
  if (timeOfDay === "evening") baseScore -= 0.5;
  if (timeOfDay === "morning") baseScore += 0.2;

  // Adjust based on weather
  if (weatherConditions === "rain") baseScore -= 0.8;
  if (weatherConditions === "snow") baseScore -= 1.2;
  if (weatherConditions === "clear") baseScore += 0.3;

  // Ensure score is within bounds
  const finalScore = Math.max(1.0, Math.min(5.0, baseScore));

  return {
    safetyScore: finalScore.toFixed(1),
    factors: {
      routeType,
      distance,
      timeOfDay,
      weatherConditions,
    },
    calculatedAt: new Date().toISOString(),
  };
});

// =========================
// EVENT-BASED FUNCTIONS
// =========================

/**
 * User creation trigger
 * Runs when a new user document is created in Firestore
 */
exports.onUserCreate = onDocumentCreated("users/{userId}", (event) => {
  const userData = event.data.data();
  const userId = event.params.userId;

  logger.info("New user created", { userId, userData });

  // Send welcome notification (in real app, you'd use FCM)
  logger.info(`Welcome to SafeStride, ${userData.name || "User"}!`);

  // Initialize user preferences
  const userPrefs = {
    notifications: true,
    safetyAlerts: true,
    routeRecommendations: true,
    createdAt: new Date().toISOString(),
  };

  // In a real app, you might write to a preferences collection
  logger.info("User preferences initialized", userPrefs);

  return null;
});

/**
 * Route creation trigger
 * Runs when a new route is created
 */
exports.onRouteCreate = onDocumentCreated("routes/{routeId}", (event) => {
  const routeData = event.data.data();
  const routeId = event.params.routeId;

  logger.info("New route created", { routeId, routeData });

  // Log route statistics
  const routeStats = {
    name: routeData.name,
    type: routeData.type,
    distance: routeData.distance,
    safetyRating: routeData.safetyRating,
    createdBy: routeData.createdBy,
    createdAt: routeData.createdAt,
  };

  logger.info("Route statistics", routeStats);

  // If safety rating is low, flag for review
  if (routeData.safetyRating < 2.5) {
    logger.warn(`Low safety rating route detected: ${routeId}`, routeStats);
  }

  return null;
});

/**
 * Route update trigger
 * Runs when a route is updated
 */
exports.onRouteUpdate = onDocumentUpdated("routes/{routeId}", (event) => {
  const beforeData = event.data.before.data();
  const afterData = event.data.after.data();
  const routeId = event.params.routeId;

  logger.info("Route updated", { routeId });

  // Track significant changes
  const changes = [];

  if (beforeData.safetyRating !== afterData.safetyRating) {
    changes.push(`Safety rating changed from ${beforeData.safetyRating} to ${afterData.safetyRating}`);
  }

  if (beforeData.distance !== afterData.distance) {
    changes.push(`Distance changed from ${beforeData.distance} to ${afterData.distance}`);
  }

  if (changes.length > 0) {
    logger.info("Route changes detected", { routeId, changes });
  }

  return null;
});

/**
 * Storage upload trigger
 * Runs when a file is uploaded to Firebase Storage
 */
exports.onFileUpload = onObjectFinalized("storage/{filePath}", (event) => {
  const object = event.data;
  const filePath = event.params.filePath;

  logger.info("File uploaded", {
    filePath,
    contentType: object.contentType,
    size: object.size,
    timeCreated: object.timeCreated,
  });

  // Log different types of uploads
  if (filePath.includes("routes/")) {
    logger.info("Route image uploaded", { filePath });
  } else if (filePath.includes("users/")) {
    logger.info("Profile image uploaded", { filePath });
  } else if (filePath.includes("uploads/")) {
    logger.info("General upload", { filePath });
  }

  // Check file size (warn if too large)
  const maxSize = 5 * 1024 * 1024; // 5MB
  if (object.size > maxSize) {
    logger.warn(`Large file uploaded: ${filePath} (${object.size} bytes)`);
  }

  return null;
});

// =========================
// HTTP FUNCTIONS (Alternative to callable)
// =========================

/**
 * Health check function
 * Simple HTTP function to check if functions are working
 */
exports.healthCheck = onRequest((request, response) => {
  logger.info("Health check called");

  response.status(200).json({
    status: "healthy",
    timestamp: new Date().toISOString(),
    service: "SafeStride Cloud Functions",
    version: "1.0.0",
  });
});

/**
 * Route statistics function
 * Returns aggregated statistics about routes
 */
exports.getRouteStats = onRequest(async (request, response) => {
  try {
    const admin = require("firebase-admin");
    const db = admin.firestore();

    logger.info("Getting route statistics");

    // Get all routes
    const routesSnapshot = await db.collection("routes").get();
    const routes = routesSnapshot.docs.map((doc) => doc.data());

    // Calculate statistics
    const stats = {
      totalRoutes: routes.length,
      averageDistance: routes.reduce((sum, route) => sum + (route.distance || 0), 0) / routes.length,
      averageSafetyRating: routes.reduce((sum, route) => sum + (route.safetyRating || 0), 0) / routes.length,
      routeTypes: {},
      createdAt: new Date().toISOString(),
    };

    // Count route types
    routes.forEach((route) => {
      const type = route.type || "unknown";
      stats.routeTypes[type] = (stats.routeTypes[type] || 0) + 1;
    });

    logger.info("Route statistics calculated", stats);

    response.status(200).json(stats);
  } catch (error) {
    logger.error("Error getting route statistics", error);
    response.status(500).json({ error: "Internal server error" });
  }
});
