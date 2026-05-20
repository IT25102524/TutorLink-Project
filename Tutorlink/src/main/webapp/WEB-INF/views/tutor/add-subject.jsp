<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    (function () {
        var tooltipStyle = {
            backgroundColor: 'rgba(15,23,42,0.92)',
            titleColor: '#f1f5f9',
            bodyColor: '#94a3b8',
            borderColor: 'rgba(255,255,255,0.08)',
            borderWidth: 1,
            padding: 12,
            cornerRadius: 10,
            titleFont: { family: 'Plus Jakarta Sans', size: 13, weight: '700' },
            bodyFont:  { family: 'Inter', size: 12 },
            displayColors: true,
            boxWidth: 10, boxHeight: 10, boxPadding: 4,
        };


        var ratingEl = document.getElementById('ratingChart');
        if (ratingEl) {
            var d1 = ratingEl.dataset;
            new Chart(ratingEl, {
                type: 'bar',
                data: {
                    labels: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'],
                    datasets: [{
                        data: [
                            Number(d1['1'] || 0),
                            Number(d1['2'] || 0),
                            Number(d1['3'] || 0),
                            Number(d1['4'] || 0),
                            Number(d1['5'] || 0)
                        ],
                        backgroundColor: [
                            'rgba(239,68,68,0.75)',
                            'rgba(249,115,22,0.75)',
                            'rgba(245,158,11,0.75)',
                            'rgba(52,211,153,0.75)',
                            'rgba(5,150,105,0.75)'
                        ],
                        borderColor: [
                            '#ef4444',
                            '#f97316',
                            '#f59e0b',
                            '#34d399',
                            '#059669'
                        ],
                        borderWidth: 2,
                        borderRadius: 8,
                        borderSkipped: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: { duration: 900, easing: 'easeOutQuart' },
                    plugins: {
                        legend: { display: false },
                        tooltip: Object.assign({}, tooltipStyle, {
                            callbacks: {
                                label: function(ctx) {
                                    var n = ctx.parsed.y;
                                    return ' ' + n + ' review' + (n !== 1 ? 's' : '');
                                }
                            }
                        })
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            suggestedMax: 5,
                            ticks: {
                                stepSize: 1,
                                precision: 0,
                                color: '#94a3b8',
                                font: { family: 'Inter', size: 11 }
                            },
                            grid: { color: 'rgba(5,150,105,0.06)' }
                        },
                        x: {
                            ticks: {
                                color: '#475569',
                                font: { family: 'Inter', size: 12, weight: '600' }
                            },
                            grid: { display: false }
                        }
                    }
                }
            });
        }


        var statusEl = document.getElementById('bookingStatusChart');
        if (statusEl) {
            var d2 = statusEl.dataset;
            new Chart(statusEl, {
                type: 'bar',
                data: {
                    labels: ['Pending', 'Confirmed', 'Completed', 'Cancelled'],
                    datasets: [{
                        data: [
                            Number(d2.pending   || 0),
                            Number(d2.confirmed || 0),
                            Number(d2.completed || 0),
                            Number(d2.cancelled || 0)
                        ],
                        backgroundColor: [
                            'rgba(245,158,11,0.75)',
                            'rgba(5,150,105,0.75)',
                            'rgba(59,130,246,0.75)',
                            'rgba(239,68,68,0.75)'
                        ],
                        borderColor: [
                            '#f59e0b',
                            '#059669',
                            '#3b82f6',
                            '#ef4444'
                        ],
                        borderWidth: 2,
                        borderRadius: 8,
                        borderSkipped: false
                    }]
                },
                options: {
                    indexAxis: 'y',
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: { duration: 900, easing: 'easeOutQuart' },
                    plugins: {
                        legend: { display: false },
                        tooltip: Object.assign({}, tooltipStyle, {
                            callbacks: {
                                label: function(ctx) {
                                    var n = ctx.parsed.x;
                                    return ' ' + n + ' booking' + (n !== 1 ? 's' : '');
                                }
                            }
                        })
                    },
                    scales: {
                        x: {
                            beginAtZero: true,
                            suggestedMax: 5,
                            ticks: {
                                stepSize: 1,
                                precision: 0,
                                color: '#94a3b8',
                                font: { family: 'Inter', size: 11 }
                            },
                            grid: { color: 'rgba(5,150,105,0.06)' }
                        },
                        y: {
                            ticks: {
                                color: '#475569',
                                font: { family: 'Inter', size: 12, weight: '600' }
                            },
                            grid: { display: false }
                        }
                    }
                }
            });
        }

    })();
</script>

<script>

    (function() {
        function animateCounter(el) {
            var target = parseInt(el.getAttribute('data-target')) || 0;
            if (target === 0) { el.textContent = '0'; return; }
            var duration = 1200;
            var start = null;
            function step(timestamp) {
                if (!start) start = timestamp;
                var progress = Math.min((timestamp - start) / duration, 1);
                var ease = 1 - Math.pow(1 - progress, 4);
                el.textContent = Math.floor(ease * target);
                if (progress < 1) requestAnimationFrame(step);
                else el.textContent = target;
            }
            requestAnimationFrame(step);
        }
        var observer = new IntersectionObserver(function(entries) {
            entries.forEach(function(e) {
                if (e.isIntersecting) { animateCounter(e.target); observer.unobserve(e.target); }
            });
        }, { threshold: 0.3 });
        document.querySelectorAll('.counter').forEach(function(el) { observer.observe(el); });
    })();

    document.querySelectorAll('a[href]').forEach(function(link) {
        var href = link.getAttribute('href');
        if (!href || href.startsWith('#') || href.startsWith('javascript') || link.target === '_blank') return;
        link.addEventListener('click', function(e) {
            var dest = link.href;
            if (dest && dest !== window.location.href) {
                e.preventDefault();
                document.body.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
                document.body.style.opacity = '0';
                document.body.style.transform = 'translateY(-8px)';
                setTimeout(function() { window.location.href = dest; }, 280);
            }
        });
    });
</script>

<script>
(function() {
    var STORAGE_KEY = 'tl_theme';
    // Clear any stale/corrupted theme value from old buggy code
    var _saved = localStorage.getItem(STORAGE_KEY);
    if (_saved !== 'light' && _saved !== 'dark') { localStorage.removeItem(STORAGE_KEY); }
    var html = document.documentElement;
    var isAdmin = document.querySelector('link[href*="admin.css"]') !== null;
    function getDefault() { return isAdmin ? 'dark' : 'light'; }
    function getOpposite(t) { return t === 'dark' ? 'light' : 'dark'; }
    function applyTheme(theme) {
        html.setAttribute('data-theme', theme);
        var icon = document.getElementById('dm-icon');
        var label = document.getElementById('dm-label');
        if (isAdmin) {
            if (icon) icon.className = theme === 'light' ? 'fas fa-moon dm-icon' : 'fas fa-sun dm-icon';
            if (label) label.textContent = theme === 'light' ? 'Dark Mode' : 'Light Mode';
        } else {
            if (icon) icon.className = theme === 'dark' ? 'fas fa-sun dm-icon' : 'fas fa-moon dm-icon';
            if (label) label.textContent = theme === 'dark' ? 'Light Mode' : 'Dark Mode';
        }
    }
    var saved = localStorage.getItem(STORAGE_KEY);
    var current = saved ? saved : getDefault();
    applyTheme(current);
    window.__tlToggleTheme = function() {
        var cur = html.getAttribute('data-theme') || getDefault(); var next = getOpposite(cur);
        localStorage.setItem(STORAGE_KEY, next);
        applyTheme(next);
    };
})();
</script>
</body>
</html>
