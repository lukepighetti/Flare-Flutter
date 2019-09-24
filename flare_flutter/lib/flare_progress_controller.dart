import 'package:flare_dart/math/mat2d.dart';

import 'flare.dart';
import 'flare_controller.dart';

/// A naiive controller that allows you to scrub through a single animation.
/// Useful for wiring up progress bars or scroll based animations.
class FlareProgressController extends FlareController {
  FlareProgressController(this.animation);

  final String animation;

  FlutterActorArtboard _artboard;
  ActorAnimation _animation;

  bool _lockAdvance;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    /// Only allow once advance per update
    if (_lockAdvance == false) {
      _lockAdvance = true;
      return true;
    } else {
      return false;
    }
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _artboard = artboard;
    if (_artboard != null) {
      _animation = artboard.getAnimation(animation);

      if (_animation != null) {
        _animation.apply(0.0, _artboard, 1.0);
      }
    }
  }

  /// Updates the animation progress and triggers a render
  void update(double t) {
    if (_animation != null) {
      final time = _animation.duration * t;
      _lockAdvance = false;
      _animation.apply(time, _artboard, 1.0);
    }
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}
}
