/* ================================================================
   Alma Presentation — Player
   Handles: viewport scaling, keyboard nav, animation triggers
   ================================================================ */
(function () {
  const scaler  = document.querySelector('.player-scaler');
  const counter = document.querySelector('.player-counter');
  const slides  = Array.from(document.querySelectorAll('.player-scaler .slide'));
  let current   = 0;

  // ── Scale stage to viewport ───────────────────────────────────
  function fitScale() {
    const s = Math.min(window.innerWidth / 1920, window.innerHeight / 1080);
    scaler.style.transform = `scale(${s})`;
  }
  window.addEventListener('resize', fitScale);
  fitScale();

  // ── Count-up ──────────────────────────────────────────────────
  function runCountUp(slide) {
    slide.querySelectorAll('.count-up[data-target]').forEach(el => {
      const target   = parseFloat(el.dataset.target);
      const prefix   = el.dataset.prefix || '';
      const suffix   = el.dataset.suffix || '';
      const duration = 1800;
      const start    = performance.now();
      function tick(now) {
        const t    = Math.min((now - start) / duration, 1);
        const ease = 1 - Math.pow(1 - t, 3);
        el.textContent = prefix + Math.round(target * ease) + suffix;
        if (t < 1) requestAnimationFrame(tick);
      }
      requestAnimationFrame(tick);
    });
  }

  // ── Show slide ────────────────────────────────────────────────
  function showSlide(index) {
    slides.forEach((s, i) => {
      if (i === index) {
        s.classList.add('active');
        // Double rAF: let browser apply initial (hidden) state first
        requestAnimationFrame(() => requestAnimationFrame(() => {
          s.classList.add('visible');
          runCountUp(s);
        }));
      } else {
        s.classList.remove('active', 'visible');
      }
    });
    if (counter) counter.textContent = `${index + 1} / ${slides.length}`;
  }

  // ── Keyboard navigation ───────────────────────────────────────
  document.addEventListener('keydown', e => {
    if (e.key === 'ArrowRight' || e.key === ' ') {
      e.preventDefault();
      current = Math.min(current + 1, slides.length - 1);
      showSlide(current);
    } else if (e.key === 'ArrowLeft') {
      e.preventDefault();
      current = Math.max(current - 1, 0);
      showSlide(current);
    } else if (e.key === 'Home') {
      current = 0; showSlide(current);
    } else if (e.key === 'End') {
      current = slides.length - 1; showSlide(current);
    }
  });

  // ── Init first slide ──────────────────────────────────────────
  if (slides.length > 0) {
    slides[0].classList.add('active');
    if (counter) counter.textContent = `1 / ${slides.length}`;
    setTimeout(() => {
      slides[0].classList.add('visible');
      runCountUp(slides[0]);
    }, 120);
  }
})();
