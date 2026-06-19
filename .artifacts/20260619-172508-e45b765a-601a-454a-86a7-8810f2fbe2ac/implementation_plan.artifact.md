# Implementation Plan - Clinical Workspace UI Update

Modify the Clinical Workspace page to match the provided reference images, handling both empty and filled states.

## Proposed Changes

### UI Components

#### [ClinicalWorkspaceScreen.dart](file:///U:/StudioProjects/eghealthcare/lib/features/Doctor/report/presentation/pages/ClinicalWorkspaceScreen.dart)

- Refactor the main build method to separate sections into smaller, manageable widgets.
- Update `_buildAppBar` (or replace with a custom header) to include patient name, date, time, and status badge.
- Implement `_buildHeader` for the top section of the page.
- Update `_buildLeftPanel` (Smart Report Editor):
    - Add icons to section titles.
    - Style template buttons to match the reference.
    - Style the Consultation Report text area and "Save" button.
- Update `_buildRightPanel` (RAG Agent & Insights):
    - Implement `_buildInsightsSection` with styled cards for Allergies, Medications, and Conditions.
    - Implement `_buildTimelineSection` with a vertical timeline layout.
    - Refine `_buildChatSection` with better message bubbles and input field styling.
- Ensure the layout is responsive (desktop vs mobile) as already partially implemented.

### Models & BLoC

#### [workspace_state.dart](file:///U:/StudioProjects/eghealthcare/lib/features/Doctor/report/presentation/bloc/workspace_state.dart)

- (Optional) Add dummy data for timeline and insights to demonstrate the filled state when `hasHistory` is true.

## Verification Plan

### Manual Verification
- Run the application and navigate to the Clinical Workspace page.
- Verify the "Empty State" layout matches the first image when `hasHistory` is false (can be toggled in `LoadWorkspaceData` event).
- Verify the "Filled State" layout matches the subsequent images when `hasHistory` is true.
- Check responsiveness by resizing the window.
- Verify that clicking templates or sending chat messages still triggers the BLoC events.
