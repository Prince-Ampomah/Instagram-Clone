import 'package:flutter/material.dart';

class ProfileImageOverlayController {
  OverlayEntry? overlayEntry;

  void createProfilePicOverlay(
    BuildContext context,
    Widget overlayWidget,
  ) {
    // Remove the existing OverlayEntry.
    removeProfilePicOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) => overlayWidget,
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(
      context,
    ).insert(overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeProfilePicOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}


/**
 * 
 *  
 * OverlayEntry? overlayEntry;
  void createProfilePicOverlay() {
    // Remove the existing OverlayEntry.
    removeProfilePicOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        return ProfileImageOverlay(
          onTap: removeProfilePicOverlay,
          imageUrl: userModel!.profileImage!,
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(
      context,
      debugRequiredFor: widget,
    ).insert(overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeProfilePicOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

 */