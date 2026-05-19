<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="TutorLink - Find verified home tutors in Sri Lanka. Search by subject, compare rates, and book sessions instantly.">
    <title>TutorLink - Find Your Perfect Home Tutor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
</head>
<body>

<jsp:include page="shared/navbar.jsp"/>
<section class="hero" id="hero">
    <div class="hero-bg-images">
        <div class="hero-bg-img hero-bg-img-1">
            <img src="${pageContext.request.contextPath}/images/tutor-male.png" alt="">
        </div>
        <div class="hero-bg-img hero-bg-img-2">
            <img src="${pageContext.request.contextPath}/images/student-female.png" alt="">
        </div>
        <div class="hero-bg-img hero-bg-img-3">
            <img src="${pageContext.request.contextPath}/images/tutor-female.png" alt="">
        </div>
    </div>
    <div class="hero-overlay"></div>
    <div class="hero-bg-orbs">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
    </div>
    <div class="hero-grid-pattern"></div>

    <div class="container position-relative" style="z-index:5;">
        <div class="row justify-content-center">
            <div class="col-lg-8 text-center" id="heroLeft">
                <div class="hero-badge">
                    <span class="badge-dot"></span> Sri Lanka's #1 Tutor Platform
                </div>
                <h1 class="hero-title">
                    Find the Perfect<br>
                    <span class="gradient-text">Home Tutor</span><br>
                    Near You
                </h1>
                <p class="hero-desc" style="margin-left:auto;margin-right:auto;">Connect with qualified, verified tutors in your district. Search by subject, compare rates, and book sessions in minutes.</p>
                <div class="hero-buttons" style="justify-content:center;">
                    <a href="${pageContext.request.contextPath}/register/student" class="btn-hero-primary" id="findTutorBtn">
                        <i class="fas fa-search"></i> Find a Tutor
                        <span class="btn-shine"></span>
                    </a>
                    <a href="${pageContext.request.contextPath}/register/tutor" class="btn-hero-secondary" id="becomeTutorBtn">
                        <i class="fas fa-chalkboard-teacher"></i> Become a Tutor
                    </a>
                </div>
                <div class="hero-stats" style="justify-content:center;">
                    <div class="stat-item"><div class="stat-number" data-target="500">0</div><div class="stat-label">Tutors</div></div>
                    <div class="stat-divider"></div>
                    <div class="stat-item"><div class="stat-number" data-target="2000">0</div><div class="stat-label">Students</div></div>
                    <div class="stat-divider"></div>
                    <div class="stat-item"><div class="stat-number" data-target="25">0</div><div class="stat-label">Subjects</div></div>
                    <div class="stat-divider"></div>
                    <div class="stat-item"><div class="stat-number" data-target="13">0</div><div class="stat-label">Districts</div></div>
                </div>
            </div>
        </div>
    </div>
    <div class="hero-float-cards">
        <div class="hero-glass-card floating-card card-left">
            <div class="fc-content">
                <div class="fc-icon green"><i class="fas fa-check-circle"></i></div>
                <div><div class="fc-title">Session Booked!</div><div class="fc-sub">Physics - Tomorrow 4PM</div></div>
            </div>
        </div>
        <div class="hero-glass-card floating-card card-right">
            <div class="fc-content">
                <div class="fc-icon blue"><i class="fas fa-star"></i></div>
                <div><div class="fc-title">5.0 Rating</div><div class="fc-sub">"Excellent teacher!"</div></div>
            </div>
        </div>
    </div>

    <div class="hero-scroll-indicator" id="scrollIndicator">
        <span>Scroll to explore</span>
        <div class="scroll-arrow"><i class="fas fa-chevron-down"></i></div>
    </div>
</section>
<section class="section" id="features">
    <div class="container">
        <div class="section-header">
            <div class="section-badge">Features</div>
            <h2 class="section-title">Everything You Need to <span>Learn & Grow</span></h2>
            <p class="section-sub">Built specifically for Sri Lankan students and tutors</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card" id="featureSearch">
                    <div class="fc-icon-wrap blue"><i class="fas fa-search"></i></div>
                    <h5>Smart Search</h5>
                    <p>Filter tutors by subject and district. Find exactly who you need in seconds.</p>
                    <div class="fc-link">Learn more <i class="fas fa-arrow-right"></i></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card" id="featureBooking">
                    <div class="fc-icon-wrap green"><i class="fas fa-calendar-check"></i></div>
                    <h5>Easy Booking</h5>
                    <p>Send booking requests instantly. Choose your date, time and teaching mode.</p>
                    <div class="fc-link">Learn more <i class="fas fa-arrow-right"></i></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card" id="featureReviews">
                    <div class="fc-icon-wrap gold"><i class="fas fa-star"></i></div>
                    <h5>Verified Reviews</h5>
                    <p>Read honest reviews from real students who completed sessions.</p>
                    <div class="fc-link">Learn more <i class="fas fa-arrow-right"></i></div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="section section-dark" id="howItWorks">
    <div class="container">
        <div class="section-header">
            <div class="section-badge light">Process</div>
            <h2 class="section-title light">How It <span>Works</span></h2>
            <p class="section-sub light">Get started in 3 simple steps</p>
        </div>
        <div class="steps-timeline">
            <div class="timeline-line"></div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="step-card">
                        <div class="step-number">01</div>
                        <div class="step-icon"><i class="fas fa-user-plus"></i></div>
                        <h5>Create Account</h5>
                        <p>Register as Student or Tutor in 2 minutes. Completely free to join.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="step-card">
                        <div class="step-number">02</div>
                        <div class="step-icon"><i class="fas fa-search-plus"></i></div>
                        <h5>Search & Compare</h5>
                        <p>Browse tutor profiles, compare rates and read genuine reviews.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="step-card">
                        <div class="step-number">03</div>
                        <div class="step-icon"><i class="fas fa-rocket"></i></div>
                        <h5>Book & Learn</h5>
                        <p>Send a booking request. Once confirmed, start your learning journey.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="section" id="subjects">
    <div class="container">
        <div class="section-header">
            <div class="section-badge">Subjects</div>
            <h2 class="section-title">Popular <span>Subjects</span></h2>
            <p class="section-sub">Find expert tutors across all major subjects</p>
        </div>
        <div class="subjects-grid">
            <div class="subject-pill"><i class="fas fa-calculator"></i> Mathematics</div>
            <div class="subject-pill"><i class="fas fa-flask"></i> Science</div>
            <div class="subject-pill"><i class="fas fa-atom"></i> Physics</div>
            <div class="subject-pill"><i class="fas fa-dna"></i> Biology</div>
            <div class="subject-pill"><i class="fas fa-vial"></i> Chemistry</div>
            <div class="subject-pill"><i class="fas fa-language"></i> English</div>
            <div class="subject-pill"><i class="fas fa-landmark"></i> History</div>
            <div class="subject-pill"><i class="fas fa-laptop-code"></i> ICT</div>
            <div class="subject-pill"><i class="fas fa-chart-line"></i> Commerce</div>
            <div class="subject-pill"><i class="fas fa-paint-brush"></i> Art</div>
            <div class="subject-pill"><i class="fas fa-globe-asia"></i> Geography</div>
            <div class="subject-pill"><i class="fas fa-book"></i> Sinhala</div>
        </div>
    </div>
</section>
<section class="section section-dark" id="testimonials">
    <div class="container">
        <div class="section-header">
            <div class="section-badge light">Testimonials</div>
            <h2 class="section-title light">What Students <span>Say</span></h2>
            <p class="section-sub light">Real feedback from our community</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="testimonial-card">
                    <div class="tc-stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                    <p>"Found an amazing math tutor within minutes. My grades improved from C to A in just 2 months!"</p>
                    <div class="tc-author">
                        <div class="tc-avatar" style="background:#6366f1;">N</div>
                        <div><div class="tc-name">Nimesh P.</div><div class="tc-role">A/L Student, Colombo</div></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonial-card">
                    <div class="tc-stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                    <p>"The booking system is so easy to use. I love that I can check tutor availability before booking."</p>
                    <div class="tc-author">
                        <div class="tc-avatar" style="background:#ec4899;">S</div>
                        <div><div class="tc-name">Sachini K.</div><div class="tc-role">O/L Student, Kandy</div></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonial-card">
                    <div class="tc-stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                    <p>"As a tutor, TutorLink helped me reach more students. The platform is professional and reliable."</p>
                    <div class="tc-author">
                        <div class="tc-avatar" style="background:#10b981;">R</div>
                        <div><div class="tc-name">Ruwan M.</div><div class="tc-role">Tutor, Galle</div></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="cta-section" id="ctaSection">
    <div class="cta-bg-orbs">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
    </div>
    <div class="container position-relative">
        <h2>Ready to Start Your Learning Journey?</h2>
        <p>Join thousands of students already learning with TutorLink</p>
        <div class="cta-buttons">
            <a href="${pageContext.request.contextPath}/register" class="btn-cta-primary" id="ctaGetStarted">
                Get Started Free <i class="fas fa-arrow-right"></i>
                <span class="btn-shine"></span>
            </a>
            <a href="${pageContext.request.contextPath}/login" class="btn-cta-secondary" id="ctaLogin">
                <i class="fas fa-sign-in-alt"></i> Login
            </a>
        </div>
    </div>
</section>
<footer id="mainFooter">
    <div class="container">
        <div class="footer-top">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="footer-brand">
                        <div class="nav-logo"><i class="fas fa-graduation-cap"></i></div>
                        <span>Tutor<span>Link</span></span>
                    </div>
                    <p class="footer-desc">Connecting students with the best home tutors across Sri Lanka. Learn better, grow faster.</p>
                </div>
                <div class="col-md-2">
                    <h6>Platform</h6>
                    <a href="${pageContext.request.contextPath}/register/student">Find Tutors</a>
                    <a href="${pageContext.request.contextPath}/register/tutor">Become a Tutor</a>
                    <a href="${pageContext.request.contextPath}/register">Register</a>
                </div>
                <div class="col-md-2">
                    <h6>Subjects</h6>
                    <a href="#">Mathematics</a>
                    <a href="#">Science</a>
                    <a href="#">English</a>
                </div>
                <div class="col-md-4">
                    <h6>Stay Connected</h6>
                    <p class="footer-desc" style="margin-bottom:1rem;">Get updates about new tutors and features.</p>
                    <div class="footer-social">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2025 <strong>TutorLink</strong> &bull; SE1020 Object Oriented Programming &bull; SLIIT</p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function animateCounters() {
        document.querySelectorAll('.stat-number').forEach(el => {
            const target = +el.dataset.target;
            const duration = 2000;
            const start = performance.now();
            function update(now) {
                const elapsed = now - start;
                const progress = Math.min(elapsed / duration, 1);
                const eased = 1 - Math.pow(1 - progress, 3);
                let val = Math.floor(eased * target);
                el.textContent = val >= 1000 ? (val / 1000).toFixed(0) + 'K+' : (target > 20 ? val + '+' : val);
                if (progress < 1) requestAnimationFrame(update);
            }
            requestAnimationFrame(update);
        });
    }

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-in');
                if (entry.target.id === 'heroLeft') animateCounters();
            }
        });
    }, { threshold: 0.15 });

    document.querySelectorAll('#heroLeft, #heroRight, .feature-card, .step-card, .testimonial-card, .section-header, .subjects-grid').forEach(el => observer.observe(el));

    document.addEventListener('mousemove', (e) => {
        const x = (e.clientX / window.innerWidth - 0.5) * 30;
        const y = (e.clientY / window.innerHeight - 0.5) * 30;
        document.querySelectorAll('.orb').forEach((orb, i) => {
            const factor = (i + 1) * 0.5;
            orb.style.transform = 'translate(' + (x * factor) + 'px, ' + (y * factor) + 'px)';
        });
    });

    document.getElementById('scrollIndicator')?.addEventListener('click', () => {
        document.getElementById('features').scrollIntoView({ behavior: 'smooth' });
    });
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const avatars = document.querySelectorAll('.tc-avatar, .tutor-avatar-large, .profile-avatar, .tb-avatar');
        const gradients = [
            'linear-gradient(135deg, #3b82f6, #60a5fa)',
            'linear-gradient(135deg, #10b981, #34d399)',
            'linear-gradient(135deg, #f59e0b, #fbbf24)',
            'linear-gradient(135deg, #8b5cf6, #a78bfa)',
            'linear-gradient(135deg, #f43f5e, #fb7185)',
            'linear-gradient(135deg, #06b6d4, #22d3ee)'
        ];
        avatars.forEach(avatar => {
            const text = avatar.innerText.trim();
            if (text.length > 0) {
                const charCode = text.charCodeAt(0);
                const colorIndex = charCode % gradients.length;
                avatar.style.background = gradients[colorIndex];
                avatar.style.color = '#fff';
                avatar.style.border = 'none';
            }
        });
    });
</script>
</body>
</html>
