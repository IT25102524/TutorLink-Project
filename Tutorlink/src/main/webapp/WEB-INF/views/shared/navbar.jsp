<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav id="mainNav">
    <div class="nav-container">

        <a href="${pageContext.request.contextPath}/" class="nav-brand">
            <div class="nav-logo">
                <i class="fas fa-graduation-cap"></i>
            </div>
            <span class="nav-brand-text">Tutor<span>Link</span></span>
        </a>
        <button class="nav-toggle" id="navToggle" aria-label="Toggle navigation">
            <span></span><span></span><span></span>
        </button>

        <div class="nav-links" id="navLinks">
            <c:choose>
                <c:when test="${sessionScope.role == 'STUDENT'}">
                    <a href="${pageContext.request.contextPath}/student/dashboard" class="nav-link">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/student/search" class="nav-link">Find Tutors</a>
                    <a href="${pageContext.request.contextPath}/student/profile" class="nav-link">Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-btn-outline">Logout</a>
                </c:when>

                <c:when test="${sessionScope.role == 'TUTOR'}">
                    <a href="${pageContext.request.contextPath}/tutor/dashboard" class="nav-link">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/tutor/profile" class="nav-link">Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-btn-outline">Logout</a>
                </c:when>

                <c:when test="${sessionScope.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">Users</a>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-btn-outline">Logout</a>
                </c:when>

                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="nav-btn-primary">Get Started</a>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</nav>

<style>
    #mainNav {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        padding: 0;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        background: transparent;
    }
    #mainNav.scrolled {
        background: rgba(10, 15, 30, 0.85);
        backdrop-filter: blur(20px) saturate(180%);
        -webkit-backdrop-filter: blur(20px) saturate(180%);
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.25);
    }
    .nav-container {
        max-width: 1240px;
        margin: 0 auto;
        padding: 0 2rem;
        height: 72px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .nav-brand {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
    }
    .nav-logo {
        width: 40px;
        height: 40px;
        background: linear-gradient(135deg, #2563eb, #3b82f6);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 1rem;
        box-shadow: 0 4px 15px rgba(37, 99, 235, 0.4);
        transition: transform 0.3s;
    }
    .nav-brand:hover .nav-logo {
        transform: rotate(-8deg) scale(1.05);
    }
    .nav-brand-text {
        font-size: 1.25rem;
        font-weight: 800;
        color: #fff;
        letter-spacing: -0.3px;
    }
    .nav-brand-text span {
        color: rgba(255, 255, 255, 0.5);
    }
    .nav-links {
        display: flex;
        align-items: center;
        gap: 6px;
    }
    .nav-link {
        color: rgba(255, 255, 255, 0.7);
        padding: 8px 16px;
        border-radius: 10px;
        text-decoration: none;
        font-size: 0.9rem;
        font-weight: 500;
        transition: all 0.25s;
        position: relative;
    }
    .nav-link:hover {
        color: #fff;
        background: rgba(255, 255, 255, 0.08);
    }
    .nav-btn-outline {
        color: rgba(255, 255, 255, 0.85);
        padding: 8px 20px;
        border-radius: 10px;
        text-decoration: none;
        font-size: 0.875rem;
        font-weight: 600;
        border: 1px solid rgba(255, 255, 255, 0.2);
        background: rgba(255, 255, 255, 0.06);
        transition: all 0.25s;
        margin-left: 6px;
    }
    .nav-btn-outline:hover {
        background: rgba(255, 255, 255, 0.12);
        border-color: rgba(255, 255, 255, 0.35);
        color: #fff;
    }
    .nav-btn-primary {
        background: linear-gradient(135deg, #2563eb, #3b82f6);
        color: #fff;
        padding: 9px 24px;
        border-radius: 10px;
        font-weight: 700;
        font-size: 0.875rem;
        text-decoration: none;
        margin-left: 6px;
        transition: all 0.3s;
        box-shadow: 0 4px 15px rgba(37, 99, 235, 0.35);
    }
    .nav-btn-primary:hover {
        transform: translateY(-1px);
        box-shadow: 0 8px 25px rgba(37, 99, 235, 0.5);
        color: #fff;
    }

    .nav-toggle {
        display: none;
        flex-direction: column;
        gap: 5px;
        background: none;
        border: none;
        cursor: pointer;
        padding: 6px;
    }
    .nav-toggle span {
        width: 22px;
        height: 2px;
        background: #fff;
        border-radius: 2px;
        transition: all 0.3s;
    }
    @media (max-width: 768px) {
        .nav-toggle { display: flex; }
        .nav-links {
            position: fixed;
            top: 72px;
            left: 0;
            right: 0;
            background: rgba(10, 15, 30, 0.95);
            backdrop-filter: blur(20px);
            flex-direction: column;
            padding: 1.5rem 2rem;
            gap: 8px;
            transform: translateY(-120%);
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }
        .nav-links.active {
            transform: translateY(0);
        }
        .nav-link, .nav-btn-outline, .nav-btn-primary {
            width: 100%;
            text-align: center;
            margin-left: 0;
        }
    }
</style>

<script>
    window.addEventListener('scroll', function() {
        const nav = document.getElementById('mainNav');
        if (window.scrollY > 30) {
            nav.classList.add('scrolled');
        } else {
            nav.classList.remove('scrolled');
        }
    });
    document.getElementById('navToggle').addEventListener('click', function() {
        document.getElementById('navLinks').classList.toggle('active');
    });
</script>
