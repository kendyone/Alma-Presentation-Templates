/**
 * Alma Presentation — Animation Trigger
 *
 * Usage in templates:  <script src="../animations.js"></script>
 * Usage in generated output: inline this file content in a <script> tag
 *
 * What it does:
 *  1. Adds .visible to each .slide when it enters the viewport
 *     → triggers CSS animations in animations.css
 *  2. Starts count-up for any .count-up[data-target] elements inside
 *
 * Count-up markup:
 *   <span class="count-up" data-target="85" data-suffix=" %">85 %</span>
 *   data-target  → numeric end value (required)
 *   data-prefix  → text before the number (optional, e.g. "+")
 *   data-suffix  → text after  the number (optional, e.g. " %" or "M €")
 *   textContent  → fallback shown before JS runs (keep it as the final value)
 */
(function () {
  'use strict';

  function animateCount(el) {
    var target   = parseFloat(el.dataset.target);
    if (isNaN(target)) return;
    var prefix   = el.dataset.prefix  || '';
    var suffix   = el.dataset.suffix  || '';
    var decimals = (String(target).split('.')[1] || '').length;
    var duration = 1800;
    var startTime = performance.now();

    (function tick(now) {
      var p    = Math.min((now - startTime) / duration, 1);
      var ease = 1 - Math.pow(1 - p, 3); // ease-out cubic
      el.textContent = prefix + (target * ease).toFixed(decimals) + suffix;
      if (p < 1) requestAnimationFrame(tick);
    })(startTime);
  }

  function showSlide(slide) {
    if (slide.classList.contains('visible')) return;
    slide.classList.add('visible');
    slide.querySelectorAll('.count-up').forEach(animateCount);
  }

  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (e) {
      if (e.isIntersecting) showSlide(e.target);
    });
  }, { threshold: 0.15 });

  document.querySelectorAll('.slide').forEach(function (slide) {
    observer.observe(slide);
    // Trigger immediately for single-slide pages (slide already in viewport on load)
    var r = slide.getBoundingClientRect();
    if (r.top < window.innerHeight && r.bottom > 0) {
      setTimeout(function () { showSlide(slide); }, 50);
    }
  });
})();
