# Design System & Theme Redesign Backlog

Future improvements for `thanks_design_system` and [design_system.md](.agents/rules/design_system.md) to support consistent dashboards and higher user engagement across all projects.

1. **Increase Touch & Click Target Sizes**
   - [Material Design 3 Touch Targets](https://m3.material.io/foundations/designing/structure) and [Density Guidelines](https://m3.material.io/foundations/layout/grids-spacing/density) recommend **44×44dp** minimum for pointer/mouse targets and **48×48dp** for touch, with at least **8dp** spacing between targets.
   - Review `ThanksSpacing.buttonHeight` (`32px`) and `inputHeight` (`40px`) so primary buttons and mobile/tablet controls meet comfortable hit-area targets.

2. **Add Missing Dashboard Building Blocks**
   - **KPI / Metric Summary Card:** Standard card layout pairing a bold numeral (`headlineMedium` 28px or `displaySmall` 36px per [Material Design 3 Typography](https://m3.material.io/styles/typography/applying-type)) with a label and trend badge (`success` / `error`).
   - **Standard Search & Filter Bar (`ThanksSearchField`):** Formalize leading search icon, clear `✕` button, `inputFieldWidthFilter` (`240px`), and responsive wrapping alongside `ThanksPillSelector` and `ThanksDateRangePickerButton`.
   - **Operational Table / List Row:** Standardize column headers, row hover (`surface.hover`), and trailing overflow menus (`ThanksPopupMenuButton`) for dense data lists.

3. **Add `large` (`24px`) Spacing Token**
   - Extend `ThanksSpacing` beyond `16px` (`medium`) with `large = 24.0` (and `extraLarge = 32.0`) so dashboard sections, empty states, and dialogs have clear breathing room.

4. **Improve `textMuted` Contrast**
   - `Colors.black45` can look faint on `#F5F5F5` and `#FFFFFF` for form labels (`labelLarge` / `labelMedium`) and timestamps. Shift `textMuted` to a higher-contrast neutral (around `#5F5B54`).

5. **Add Keyboard Focus Ring & Interactive Card Hover**
   - `theme.dart` currently sets `elevation: 0` on cards and `focusColor: Colors.transparent` on inputs. Add a visible `2px` `primary.main` focus ring ([Material Design 3 Structure](https://m3.material.io/foundations/designing/structure)) and `surface.hover` feedback on clickable cards.
