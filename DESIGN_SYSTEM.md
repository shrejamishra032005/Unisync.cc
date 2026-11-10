# UNISYC Design System Documentation

## Overview

UNISYC uses a modern, premium SaaS design system with full support for light and dark themes. The design system is built with Tailwind CSS and uses CSS variables for theme management.

## Color System

### Light Theme
- **Background**: `#F8FAFC` - Primary app background
- **Surface**: `#FFFFFF` - Cards and containers
- **Surface Secondary**: `#F8FAFC` - Alternate surface
- **Text Primary**: `#0F172A` - Main text
- **Text Secondary**: `#64748B` - Secondary text
- **Text Tertiary**: `#94A3B8` - Tertiary text
- **Border**: `#E2E8F0` - Borders and dividers
- **Primary**: `#7C3AED` - Main action color (Purple)
- **Secondary**: `#06B6D4` - Accent color (Cyan)

### Dark Theme
- **Background**: `#0B0F19` - Primary app background
- **Surface**: `#111827` - Cards and containers
- **Surface Secondary**: `#1F2937` - Alternate surface
- **Text Primary**: `#E5E7EB` - Main text
- **Text Secondary**: `#9CA3AF` - Secondary text
- **Text Tertiary**: `#6B7280` - Tertiary text
- **Border**: `#1F2937` - Borders and dividers
- **Primary**: `#8B5CF6` - Main action color (Purple)
- **Secondary**: `#22D3EE` - Accent color (Cyan)

## Typography

All typography uses **Inter** font family.

### Heading Styles
- **H1**: `text-4xl / font-bold / -0.02em tracking`
- **H2**: `text-3xl / font-semibold / -0.01em tracking`
- **H3**: `text-2xl / font-semibold`
- **H4**: `text-xl / font-semibold`

### Body Styles
- **Body Base**: `text-base / font-normal / 1.5 line-height`
- **Body Small**: `text-sm / font-normal / 1.25 line-height`
- **Button**: `text-sm / font-medium / 1.25 line-height`

## Component Classes

### Cards
```html
<!-- Basic card -->
<div class="card">Content</div>

<!-- Hover effect -->
<div class="card card-hover">Clickable card</div>

<!-- Interactive (cursor pointer) -->
<div class="card card-interactive">Interactive card</div>
```

### Buttons
```html
<!-- Primary button (gradient) -->
<button class="btn-primary">Primary Action</button>

<!-- Secondary button (outlined) -->
<button class="btn-secondary">Secondary Action</button>

<!-- Outline button -->
<button class="btn-outline">Outline Action</button>

<!-- Ghost button -->
<button class="btn-ghost">Ghost Action</button>

<!-- Sizes -->
<button class="btn-primary btn-sm">Small</button>
<button class="btn-primary btn-lg">Large</button>
```

### Form Inputs
```html
<!-- Text input -->
<input type="text" class="input-base" />

<!-- Textarea -->
<textarea class="textarea-base"></textarea>
```

### Badges
```html
<span class="badge badge-primary">Primary</span>
<span class="badge badge-secondary">Secondary</span>
<span class="badge badge-success">Success</span>
<span class="badge badge-warning">Warning</span>
<span class="badge badge-error">Error</span>
```

### Typography Helpers
```html
<h1 class="heading-1">Large Heading</h1>
<h2 class="heading-2">Medium Heading</h2>
<h3 class="heading-3">Small Heading</h3>
<h4 class="heading-4">Extra Small Heading</h4>

<p class="text-body-base">Body text</p>
<p class="text-body-sm">Small body text</p>
```

### Effects
```html
<!-- Gradient text -->
<span class="gradient-text">Gradient text effect</span>

<!-- Gradient background -->
<div class="gradient-bg">Gradient background</div>

<!-- Glass morphism -->
<div class="glass">Glass effect</div>

<!-- Border glow -->
<div class="border-glow">Glowing border</div>

<!-- Glow effect -->
<div class="glow-effect">Shadow glow</div>
```

## CSS Variables Usage

Use CSS variables for dynamic theming in custom styles:

```css
.my-custom-component {
  background-color: var(--surface);
  color: var(--text-primary);
  border: 1px solid var(--border);
}
```

## Sidebar Navigation

Sidebar items use the `.sidebar-item` and `.sidebar-item-active` classes:

```html
<nav class="flex flex-col gap-1">
  <a href="/page" class="sidebar-item">Link</a>
  <a href="/active" class="sidebar-item sidebar-item-active">Active Link</a>
</nav>
```

## Transitions & Animations

All components use smooth transitions:
- **Fast**: `duration-150ms`
- **Base**: `duration-200ms` (default)

Hover effects include:
- Scale: `hover:scale-105`
- Shadow: `hover:shadow-lg`
- Brightness: Applied via opacity

## Box Shadows

Pre-defined shadows:
- `.shadow-light-sm` - Small shadow
- `.shadow-light-md` - Medium shadow
- `.shadow-light-lg` - Large shadow
- `.shadow-card` - Card shadow (light theme)
- `.shadow-card-dark` - Card shadow (dark theme)
- `.shadow-glow-purple` - Purple glow
- `.shadow-glow-cyan` - Cyan glow

## Border Radius

- Cards: `rounded-2xl` (1rem)
- Buttons: `rounded-lg` (0.5rem)
- Inputs: `rounded-lg` (0.5rem)

## Theme Switching

The theme provider handles automatic theme switching:

1. **Auto-detect**: System preference on first visit
2. **Manual toggle**: User can switch in sidebar
3. **Persistence**: Theme choice saved in localStorage
4. **HTML class**: `dark` class added to `<html>` element in dark mode

## Responsive Design

The design system is fully responsive using Tailwind's breakpoints:
- `sm`: 640px
- `md`: 768px
- `lg`: 1024px
- `xl`: 1280px
- `2xl`: 1536px

## Consistency Guidelines

### Do's:
- ✅ Use predefined component classes (`.btn-primary`, `.card`, etc.)
- ✅ Use CSS variables for colors
- ✅ Apply consistent spacing (use multiples of 4px)
- ✅ Follow typography hierarchy
- ✅ Maintain 12px border radius on rounded elements
- ✅ Use gradient backgrounds for visual interest

### Don'ts:
- ❌ Don't hardcode colors - use CSS variables
- ❌ Don't create one-off styles - use component classes
- ❌ Don't mix old and new component styles
- ❌ Don't ignore theme context - always support dark mode
- ❌ Don't use random font sizes - stick to the scale
- ❌ Don't add shadows without using predefined classes

## Best Practices

1. **Always wrap custom styles in the design system**
   ```html
   <!-- Good -->
   <div class="card p-6">
     <h3 class="heading-3">Title</h3>
   </div>

   <!-- Avoid -->
   <div class="bg-white border rounded p-6">
     <h3 class="text-2xl font-bold">Title</h3>
   </div>
   ```

2. **Use semantic class names**
   ```html
   <!-- Good -->
   <button class="btn-primary">Submit</button>

   <!-- Avoid -->
   <button class="bg-purple-600 text-white px-4 py-2">Submit</button>
   ```

3. **Support both themes**
   ```css
   /* Good - will adapt to theme automatically */
   .my-element {
     background: var(--surface);
     color: var(--text-primary);
   }

   /* Avoid - hard-coded to light theme */
   .my-element {
     background: white;
     color: #000;
   }
   ```

4. **Use responsive classes**
   ```html
   <!-- Good -->
   <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3">
     Cards...
   </div>

   <!-- Avoid -->
   <div class="grid grid-cols-3">
     Cards...
   </div>
   ```

## Component Examples

### Feature Card
```tsx
<div className="card card-hover">
  <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-[var(--primary)]/15">
    <Icon className="h-6 w-6 text-[var(--primary)]" />
  </div>
  <h3 className="heading-4 mt-4 mb-2">Feature Title</h3>
  <p className="text-body-sm text-[var(--text-secondary)]">Feature description</p>
</div>
```

### Form Section
```tsx
<div className="card space-y-6">
  <div>
    <label className="block text-sm font-medium mb-2">Label</label>
    <input type="text" className="input-base" placeholder="..." />
  </div>
  <button className="btn-primary">Submit</button>
</div>
```

### Status Badge
```tsx
<div className="flex items-center gap-2">
  <div className="w-2 h-2 rounded-full bg-[var(--success)]" />
  <span className="text-sm text-[var(--text-secondary)]">Active</span>
</div>
```

## Troubleshooting

**Colors not updating when theme switches?**
- Ensure you're using CSS variables (`var(--primary)`) not hardcoded colors
- Check that Tailwind is rebuilding

**Buttons look different in light/dark?**
- Some buttons use `btn-base` as a foundation - check parent overrides
- Verify `.dark` class is on `<html>` element

**Spacing feels inconsistent?**
- Check that you're using Tailwind's spacing scale (4px units)
- Use predefined component padding when available

## Design System Playground

Visit `/design-system` to see all components in action and explore the full design system visually.
