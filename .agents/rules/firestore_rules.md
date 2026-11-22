# Firestore & Storage Security Rules Invariants

> [!IMPORTANT]
> **MANDATORY SECURITY RULES — STRICT ENFORCEMENT**
> Because clients use **Direct Firebase Client SDK First**, `firestore.rules` and `storage.rules` are the primary enforcement boundary for data access, multi-tenancy, and schema integrity. Every rule change MUST be accompanied by emulator tests proving both allowed and denied paths.

## 1. Default-Deny & Explicit Match Boundaries
- **Default-Deny Root:** Always start `firestore.rules` and `storage.rules` with a catch-all deny rule (`match /{document=**} { allow read, write: if false; }`) and grant access only on explicit collection/path matches.
- **No Unauthenticated Wildcards:** Never use `allow read, write: if request.auth != null;` on broad paths without role, ownership, or tenant checks.
- **Backend-Only Collections:** Collections managed exclusively by Cloud Functions or Admin SDK (e.g., audit logs, counters, internal job/webhook state) MUST explicitly set `allow read, write: if false;` in client rules.

## 2. Authentication & Multi-Tenant Isolation
- **Verify Auth & Claims:** Always verify `request.auth != null` and derive identity/roles/tenant membership from `request.auth.uid` or trusted `request.auth.token` claims—never trust client-supplied `tenantId` or `role` fields without verifying against the authenticated user's token or membership document.
- **Cross-Tenant Fail-Closed:** Every tenant-scoped `get`, `list`, `create`, `update`, and `delete` rule MUST verify that `resource.data.tenantId` (for existing docs) and `request.resource.data.tenantId` (for incoming writes) match the caller's authorized tenant.
- **List Query Alignment:** Write `allow list` rules that work cleanly with scoped Firestore queries (avoiding unbounded `get()` fan-outs that exceed the 10-`get()` Security Rules limit).

## 3. Schema Validation & Field Immutability
- **Immutable Ownership & Audit Fields:** On `update`, explicitly block changes to immutable fields (`tenantId`, `createdBy`, `createdAt`) using `request.resource.data.diff(resource.data).affectedKeys()` or equality checks (`request.resource.data.tenantId == resource.data.tenantId`).
- **Required Fields & Types on Create/Update:** Validate required field presence (`keys().hasAll([...])`), data types (`is string`, `is timestamp`, `is int`), and allowed enum/status values (`in [...]`) matching the module's `<module>_constants` and models.
- **Prevent Privilege Escalation:** Never allow client writes to modify their own `role`, `permissions`, `subscriptionTier`, or server-managed status locks unless explicitly permitted by an admin/owner check.

## 4. Storage Rules Invariants (`storage.rules`)
- **Path-Scoped Ownership/Tenant:** Scope upload/download paths to `tenantId` or `userId` and enforce the same auth/tenant check as Firestore.
- **Size & Content-Type Limits:** Enforce `request.resource.size < <max_bytes>` and allowed `request.resource.contentType.matches(...)` on all client uploads.

## 5. Emulator Rule Tests Mandatory
- **Positive & Negative Coverage:** Every new or modified rule MUST have automated Firebase Emulator unit tests covering:
  1. Authorized actor succeeds (`assertSucceeds`).
  2. Unauthenticated user fails (`assertFails`).
  3. Cross-tenant or unauthorized-role actor fails (`assertFails`).
  4. Invalid schema or tampered immutable field fails (`assertFails`).
