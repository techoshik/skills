

# Plan

- [ ] **Plan Approved:** (Do not check this box until the user explicitly approves the entire plan before the Build phase begins).

<!-- Agent Instruction: Structure the plan by iterating through each Expected Outcome (EO) from the Idea file. For each EO, break the implementation down into horizontal architectural Checkpoints (Models -> Mock UI -> Logic). You must complete and self-review each checkpoint before moving to the next. -->

## [EO-ID] <Expected Outcome Name>
*Goal: <Brief summary of WHAT this outcome achieves>*

### Checkpoint 1: Data Models & DTOs
*Focus: Defining the structural contracts.*

- **Architecture & Contracts (The HOW):**
  - `<file_path>`: <What is being added or modified?>
- **Build Actions:**
  - <Concrete implementation action 1>
  - <Concrete implementation action 2>
- **Agent Self-Review:**
  - [ ] Verify the models strictly match the required data shape in the Idea file.
  - [ ] Verify the code complies with Freezed/DTO guidelines.
- **User Verification:**
  - **Action:** <How the human will verify this step (e.g., Code Review)>
  - [ ] **Checkpoint Approved:** (Do not check until the user explicitly approves)

### Checkpoint 2: UI Layout & States (Mocked)
*Focus: Visual and interactive verification without backend logic.*

- **Architecture & Contracts (The HOW):**
  - `<file_path>`: <What widgets or state controllers are being built?>
- **Build Actions:**
  - <Concrete implementation action 1 (must use mock data)>
- **Agent Self-Review:**
  - [ ] Read the guideline file at `.agents/guidelines/architecture_flutter.md` (specifically the Folder Structure and UI sections) and verify strict compliance.
  - [ ] Verify absolutely no real repository/backend calls are made in this checkpoint.
- **User Verification:**
  - **Open/Run:** <How to launch the specific screen>
  - **Action:** <What to click/type>
  - **Expected:** <What the UI should look like and how the mock state should react>
  - [ ] **Checkpoint Approved:** (Do not check until the user explicitly approves)

### Checkpoint 3: Repositories & Logic
*Focus: Wiring up the actual backend logic.*

- **Architecture & Contracts (The HOW):**
  - `<file_path>`: <What repositories or use cases are being built?>
- **Build Actions:**
  - <Concrete implementation action 1 (e.g., replace mock data with real database call)>
- **Agent Self-Review:**
  - [ ] Read the guideline files at `.agents/guidelines/architecture_cloud_functions.md` and `.agents/guidelines/architecture_flutter.md` to verify the logic adheres to domain rules and correctly isolates Firestore from the UI.
  - [ ] Run applicable static checks.
- **User Verification:**
  - **Action:** <How the human will verify the live, end-to-end integration>
  - [ ] **Checkpoint Approved:** (Do not check until the user explicitly approves)

<!-- Repeat the entire Checkpoint sequence for the next Expected Outcome. -->
