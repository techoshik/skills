# Module: <Module Name>

## Domain Purpose
*<1-2 sentences explaining the high-level business capability of this domain (e.g., "Manages everything related to job applications and matching").>*

## Entities
*<List the core business entities owned by this module.>*
- **<Entity Name>**: <High-level description of what this represents in the real world.>

## Core Business Rules
*<Global rules that apply to the ENTIRE module. Agents must NEVER break these in any feature.>*
- <Rule 1 (e.g., "A Worker cannot apply to a job if their profile is incomplete.")>
- <Rule 2 (e.g., "Admins have full override rights on all status changes.")>

## Features & Current State
*<List the major features that have been built. Use human-readable names.>*

- **<Feature Name>** (e.g., Job Details):
  - **Capabilities (What it does):** 
    - <e.g., "Displays job requirements and allows users to apply.">
  - **Feature Acceptance Criteria:**
    - <e.g., "The 'Apply' button must be hidden if the user has already applied.">

## Boundaries
*<What is explicitly OUT of scope for this module? What other domains does it interact with?>*
- <Boundary (e.g., "This module reads User profiles, but does NOT modify them.")>
- <Boundary (e.g., "Relies on the Auth module for role verification.")>

## Deferred / Future Scope
*<List high-level business capabilities explicitly delayed for future versions.>*
- <Deferred capability>
