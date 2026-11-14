# Design System Rules & Tokens (`thanks_design_system`)

> [!IMPORTANT]
> **MANDATORY UI & PROTOTYPE INVARIANTS — ZERO CUSTOM STYLES**
> Both **Phase 2 HTML prototypes** and **Phase 4 Flutter code** must follow this file as the single source of truth. Hardcoding `Color(0x...)`, `Colors.*`, `.withValues(alpha: ...)`, `.withOpacity(...)`, custom `TextStyle(...)`, raw `EdgeInsets.*(<number>)`, raw `SizedBox(width/height: <number>)`, or raw `Icon(size: <number>)` is **STRICTLY PROHIBITED**.

---

## 1. Missing Token or Component Protocol

- If a widget, spacing token, icon size, color role, or text style appears to be missing from `thanks_design_system`, **stop and ask the user** before inventing custom widgets, raw literals, or bespoke styles.

---

## 2. Colors & Surface Roles (`ThanksTheme.of(context)`)

Always read colors from `ThanksTheme.of(context)` (light theme only — never dark mode).

| Role | Accessor | Hex / Value | Use For |
| :--- | :--- | :--- | :--- |
| Page background | `theme.surface.page` | `#F5F5F5` | Main screen background |
| Card / panel | `theme.surface.panel` | `#FFFFFF` | Cards, dialogs, menus, containers |
| Hover / muted surface | `theme.surface.hover` | `#F0EEE9` | Secondary surfaces, hover states |
| Input fill | `theme.surface.input` | `#FFFFFF` | Text fields and dropdowns |
| Selected surface | `theme.surface.selected` | Primary tint | Active list tiles and selections |
| Subtle border | `theme.borderSubtle` | `#E2DFD8` | Card, input, and divider borders |
| Strong border | `theme.borderStrong` | `#C8C4BB` | Emphasized borders |
| Primary text | `theme.textPrimary` | `Colors.black87` | Headings, primary labels, values |
| Secondary text | `theme.textSecondary` | `Colors.black54` | Subtitles, supporting descriptions |
| Muted text | `theme.textMuted` | `Colors.black45` | Hints, timestamps, captions |

### Semantic Palettes (`theme.primary`, `theme.success`, `theme.warning`, `theme.error`, `theme.info`)
Every semantic palette exposes 5 roles: `.main`, `.onMain`, `.subtle`, `.onSubtle`, `.border`.
- **Primary:** `#1B4FD8` main, `#EBF0FD` subtle (`ThanksColors.primary50`–`primary950`)
- **Success:** `#1A7A4A` main, `#E8F7EE` subtle, `#B2DDCA` border
- **Warning:** `#8A5A00` main, `#FFF4D9` subtle, `#FFDB80` border
- **Error (`danger`):** `#B92B2B` main, `#FDEAEA` subtle, `#F4C0C0` border
- **Info:** `#1B4FD8` main, `#EBF0FD` subtle, `#C5D5F8` border

---

## 3. Typography (`Theme.of(context).textTheme` — DM Sans)

Never construct a `TextStyle(...)` from scratch. Always use `Theme.of(context).textTheme` (or `ThanksTheme.of(context).mono` for code/IDs) and only use `.copyWith(color: ...)` with a `ThanksTheme` color when needed.

| Style Token | Size / Weight | Use For |
| :--- | :--- | :--- |
| `headlineLarge` / `Medium` / `Small` | 32 / 28 / 24 (w400) | Page-level hero headers |
| `titleLarge` | 22 (w600) | AppBar titles, major section headers |
| `titleMedium` | 16 (w600) | Card titles, dialog titles, subheaders |
| `titleSmall` | 14 (w600) | List tile titles, compact card headers |
| `bodyLarge` / `bodyMedium` | 14 (w400, 1.6 height) | Primary body copy, descriptions |
| `bodySmall` | 12 (w400, 1.5 height) | Secondary body text, helper notes |
| `labelLarge` / `Medium` / `Small` | 12 / 11 / 11 (w500, muted) | Form labels, badges, metadata, errors |
| `ThanksTheme.of(context).mono` | 13 (monospace) | IDs, codes, technical snippets |

---

## 4. Spacing, Radii, Icons & Dimensions (`theme.spacing` / `ThanksSpacing`)

Consume through `final spacing = ThanksTheme.of(context).spacing;` (or `ThanksSpacing` for `const` contexts).

- **Base scale:** `extraSmall` = `4.0`, `small` = `8.0`, `medium` = `16.0`
- **Spacers (never `SizedBox(height: 12)`):** `spacing.spaceExtraSmall` (4), `spacing.spaceSmall` (8), `spacing.spaceMedium` (16)
- **Insets (never `EdgeInsets.all(12)`):**
  - Uniform: `insetExtraSmall` (4), `insetSmall` (8), `insetMedium` (16)
  - Axis: `insetSmallHorizontal`, `ThanksSpacing.insetSmallVertical`, `insetMediumHorizontal`, `insetMediumVertical`
  - Directional: `insetSmallWithLeftMedium`, `insetMediumWithFab`, `ThanksSpacing.insetSmallTop0`, `insetSmallBottom0`, `insetMediumTop0`, `insetMediumBottom0`
- **Corner radii:** `radiusSmall` (`8`), `radiusMedium` (`16`), `radiusFull` (`100`)
- **Icon sizes (never `Icon(size: 18)`):** `iconSmall` (`20` — default `IconTheme`), `iconMedium` (`40`), `iconLarge` (`60`)
- **Component & layout dimensions:** `appBarHeight` (`64`), `inputHeight` (`40`), `buttonHeight` (`32`), `inputFieldWidthFilter` (`240`), `fabClearance` (`132`), `contentWidthForm` (`FitSize.tablet`), `contentWidthWorkspace` (`FitSize.desktop`)
- **Intrinsic sizing:** Never hardcode static heights (`SizedBox(height: 500)`); use `Expanded`, `Flexible`, or intrinsic sizing.

---

## 5. Canonical Widgets (Use These — Never Build Raw Material Equivalents)

| Category | Canonical Widget(s) | Key Variants / Notes |
| :--- | :--- | :--- |
| **Page & Layout** | `ThanksScaffold`, `ThanksSection`, `ThanksGrid`, `ThanksGridItem` | `ThanksFilterDisplayMode` for responsive filters |
| **Cards** | `ThanksCard`, `ThanksDisclosureCard` | `ThanksCardVariant`, `ThanksCardSpacing` (`medium` for main cards, small for nested), `ThanksCardHeaderPosition` |
| **Buttons & Selectors** | `ThanksButton`, `ThanksPopupMenuButton`, `ThanksPillSelector`, `ThanksDateRangePicker`, `ThanksDateRangePickerButton` | `ThanksButtonVariant` (`text`, `filled`, `outlined`), `ThanksButtonColor` (`primary`, `secondary`, `tertiary`); bind `isLoading` to async state |
| **Dialogs & Toasts** | `ThanksDialog`, `ThanksToast` | `ThanksDialogAction` + `ThanksDialogActionStyle` (`text`, `outlined`, `filled`); `ThanksToastType` (`success`, `error`, `info`) |
| **States & Feedback** | `ThanksMessageView`, `ThanksSliverLoading`, `ThanksSliverEmptyState` | Use `ThanksMessageView.loading(...)` and `.error(...)` with retry |
| **Display & Forms** | `ThanksStatusBadge`, `ThanksImageView`, `ThanksInputLabel` | `ThanksBadgeTone`, `ThanksBadgeSize`, `ThanksImageShape` |

**Prohibited UI APIs:** `showDialog`, `AlertDialog`, `ScaffoldMessenger`, `SnackBar`, and raw `ElevatedButton`/`FilledButton`/`Card` where a `Thanks*` widget exists.

---

## 6. How Phase 2 HTML Prototypes Must Mirror This System

- **Light palette:** Page `#F5F5F5`, cards `#FFFFFF`, borders `#E2DFD8`, primary `#1B4FD8`, success `#1A7A4A`, warning `#8A5A00`, danger `#B92B2B`.
- **Spacing & radii:** Use the `4 / 8 / 16px` rhythm (`gap-1`, `gap-2`, `gap-4`, `p-2`, `p-4`), `8px` (`rounded-lg`) for inputs/buttons, `16px` (`rounded-2xl`) for cards/dialogs, and `20px` (`w-5 h-5`) / `40px` (`w-10 h-10`) for icons.
- **Component parity:** Visually mirror `ThanksCard`, `ThanksButton`, `ThanksDialog`, `ThanksToast`, `ThanksMessageView`, `ThanksStatusBadge`, and `ThanksPillSelector` so Phase 4 maps 1:1 to `thanks_design_system`.
- **Plain 5th-grade English:** All dialog titles, button labels, hints, and errors must use simple, everyday English.

---

## 7. Plain-Language Copy (5th-Grade Standard)

- **Everyday English Everywhere:** All user-facing copy (screen titles, dialog headers, buttons, form hints, empty states, toasts, and error messages) MUST be simple, clear, everyday English that a 5th-grade student can easily read and act on.
- **Zero Developer or Corporate Jargon:** Never expose internal terms such as *"synchronize"*, *"manage tiers"*, *"submitting payload"*, *"invalid schema"*, or *"permission denied"* to end users; say what happened and what to do next in plain words.
