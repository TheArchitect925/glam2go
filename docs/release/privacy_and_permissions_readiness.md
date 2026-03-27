# Privacy And Permissions Readiness

## Current Sensitive Areas
- account identity and session restore
- booking addresses and travel context
- notification preferences
- future notification device registration
- future media selection and upload for artist portfolio

## Current App Behavior
- notifications are preference-ready and delivery-structure-ready, but no real push permission flow is connected yet
- portfolio metadata is supported, but photo or media upload is not connected yet
- address data is used for booking coordination and travel clarity
- no production vendor SDK should be disclosed until it is actually enabled in the shipped build

## Before Public Release
- finalize privacy-policy copy
- document any platform permissions that will be requested
- align App Store privacy disclosures with actual data handling and SDK usage
- confirm whether notifications and portfolio-media permissions remain absent or become active in the final release candidate
