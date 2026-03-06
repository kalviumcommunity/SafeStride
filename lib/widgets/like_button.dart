import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool? initialLiked;
  final Color? likedColor;
  final Color? unlikedColor;
  final double? iconSize;
  final VoidCallback? onLikeChanged;
  final bool showCount;
  final int initialCount;

  const LikeButton({
    super.key,
    this.initialLiked,
    this.likedColor,
    this.unlikedColor,
    this.iconSize,
    this.onLikeChanged,
    this.showCount = false,
    this.initialCount = 0,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLiked;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialLiked ?? false;
    _likeCount = widget.initialCount;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _likeCount++;
      } else {
        _likeCount--;
      }
    });

    if (widget.onLikeChanged != null) {
      widget.onLikeChanged!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked 
                ? (widget.likedColor ?? Colors.red)
                : (widget.unlikedColor ?? Colors.grey),
            size: widget.iconSize ?? 24,
          ),
          onPressed: _toggleLike,
        ),
        if (widget.showCount)
          Text(
            '$_likeCount',
            style: TextStyle(
              color: _isLiked 
                  ? (widget.likedColor ?? Colors.red)
                  : Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
