---
trigger: always_on
description: Cloud Functions (Firebase/Node.js) specific architectural principles and best practices.
---

# Cloud Functions Architecture Guidelines

## Strict Model Adherence

- Backend models represent the absolute source of truth. Ensure that incoming request objects (DTOs) strictly map into the internal domain models.
- Silently ignoring fields sent by a client (because the backend model isn't updated) is dangerous. Ensure the backend model matches the required schema from the frontend, or explicitly reject unknown fields if strictness is required.

## Separation of Concerns

- **Use Cases vs Repositories:** Domain logic and authorization must happen in the Use Case layer, while the Repository layer strictly handles data access and Firebase/Firestore specific operations.
- Avoid using Firestore specific types (like `Timestamp`) in the presentation or HTTP entry layers when possible; keep them contained in the repositories or specific mapping boundaries.

## Concurrency & Atomicity

- Use atomic operations (Transactions, Batched Writes) for multi-document writes to prevent partial failures.
- Utilize optimistic concurrency (e.g. `revision` fields) when updating entities to prevent lost updates from concurrent users.
