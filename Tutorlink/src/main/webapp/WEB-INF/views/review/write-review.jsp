<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Write Review - TutorLink</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student.css">
    <style>
        .review-layout {
            display: flex; justify-content: center; align-items: flex-start;
            padding-top: 1rem;
        }
        .review-card {
            background: rgba(255,255,255,0.82);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 24px;
            border: 1px solid rgba(255,255,255,0.95);
            padding: 3rem;
            box-shadow: 0 20px 60px rgba(37,99,235,0.08), 0 4px 16px rgba(0,0,0,0.04);
            width: 100%;
            max-width: 650px;
            transition: box-shadow 0.3s;
        }
        .review-card:hover {
            box-shadow: 0 28px 70px rgba(37,99,235,0.12), 0 6px 20px rgba(0,0,0,0.05);
        }
        .review-header {
            text-align: center; margin-bottom: 2rem;
        }
        .review-icon {
            font-size: 2.8rem; color: #f59e0b; margin-bottom: 1.2rem;
            background: linear-gradient(135deg, #fef3c7, #fde68a); width: 85px; height: 85px; border-radius: 50%;
            display: inline-flex; align-items: center; justify-content: center;
            box-shadow: 0 10px 20px rgba(245, 158, 11, 0.15);
        }

        .star-row {
            display: flex; justify-content: center; gap: 15px;
            margin: 1.5rem 0; padding: 1.5rem; background: #f8fafc;
            border-radius: 16px; border: 2px dashed #cbd5e1;
            transition: all 0.3s;
        }
        .star-row:hover { border-color: #93c5fd; background: #eff6ff; }

        .star-lbl {
            font-size: 3rem;
            color: #e2e8f0;
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            line-height: 1; filter: drop-shadow(0 4px 6px rgba(0,0,0,0.05));
        }

        .star-lbl:hover, .star-lbl.active {
            color: #f59e0b;
            transform: scale(1.15) translateY(-5px);
            filter: drop-shadow(0 8px 15px rgba(245, 158, 11, 0.3));
        }

        .st-input {
            border: 2px solid #e2e8f0; border-radius: 14px; padding: 16px;
            font-size: 1rem; color: #0f172a; width: 100%;
            transition: all 0.3s; resize: none; background: #f8fafc;
        }
        .st-input:focus {
            border-color: #3b82f6; outline: none; background: #fff;
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15);
        }
        .st-label {
            font-weight: 800; color: #475569; text-transform: uppercase;
            font-size: 0.85rem; letter-spacing: 1px; margin-bottom: 10px; display: block;
        }
        .btn-modern {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            color: #fff; border: none; padding: 14px 32px; border-radius: 12px;
            font-weight: 700; font-size: 1.05rem; transition: all 0.3s; display: inline-flex;
            align-items: center; justify-content: center; cursor: pointer; text-decoration: none; width: 100%;
        }
        .btn-modern:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(37,99,235,0.3); color: #fff; }
        .btn-outline {
            background: #fff; color: #475569; border: 2px solid #e2e8f0;
            padding: 14px 32px; border-radius: 12px; font-weight: 700; font-size: 1.05rem;
            transition: all 0.3s; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; width: 100%;
        }
        .btn-outline:hover { background: #f1f5f9; border-color: #cbd5e1; color: #0f172a; }
    </style>
</head>
<body>

<jsp:include page="../student/sidebar.jsp"/>

<div class="main-content">
    <div class="container-fluid" style="max-width: 1200px; margin: 0 auto; padding-top: 10px;">

        <div class="d-flex align-items-center mb-4">
            <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-light rounded-circle me-3" style="width:45px;height:45px;display:flex;align-items:center;justify-content:center; box-shadow: 0 4px 10px rgba(0,0,0,0.05); border: 1px solid #e2e8f0;">
                <i class="fas fa-arrow-left"></i>
            </a>
            <h2 class="st-page-title mb-0" style="font-weight: 800; font-size: 1.6rem; color: #0f172a;">Back to Dashboard</h2>
        </div>

        <div class="review-layout">
            <div class="review-card">
                <div class="review-header">
                    <div class="review-icon"><i class="fas fa-star"></i></div>
                    <h3 style="font-weight: 800; color: #0f172a; margin-bottom: 8px;">Rate Your Experience</h3>
                    <p class="text-muted" style="font-size: 0.95rem;">Your feedback helps other students find great tutors.</p>
                </div>

                <form action="${pageContext.request.contextPath}/review/write/${bookingId}" method="post">
                    <input type="hidden" name="tutorId" value="${tutorId}">
                    <input type="hidden" name="rating" id="ratingVal" value="">

                    <div class="mb-4">
                        <label class="st-label text-center w-100">Overall Rating *</label>
                        <div class="star-row" id="starRow">
                            <span class="star-lbl" data-val="1" title="Poor"><i class="fas fa-star"></i></span>
                            <span class="star-lbl" data-val="2" title="Fair"><i class="fas fa-star"></i></span>
                            <span class="star-lbl" data-val="3" title="Good"><i class="fas fa-star"></i></span>
                            <span class="star-lbl" data-val="4" title="Very Good"><i class="fas fa-star"></i></span>
                            <span class="star-lbl" data-val="5" title="Excellent"><i class="fas fa-star"></i></span>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="st-label">Your Experience *</label>
                        <textarea name="comment" class="st-input" rows="5" required placeholder="How was your experience? Was the tutor helpful, punctual, and knowledgeable?"></textarea>
                    </div>

                    <div class="row g-3 mt-4">
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/student/dashboard" class="btn-outline">
                                Cancel
                            </a>
                        </div>
                        <div class="col-md-6">
                            <button type="submit" class="btn-modern" onclick="return validateRating()">
                                <i class="fas fa-paper-plane me-2"></i> Submit Review
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const stars = document.querySelectorAll('.star-lbl');
        stars.forEach(s => {
            s.addEventListener('click', () => {
                const val = parseInt(s.dataset.val);
                document.getElementById('ratingVal').value = val;
                stars.forEach((st, i) => {
                    if (i < val) {
                        st.style.color = '#f59e0b';
                        st.classList.add('active');
                    } else {
                        st.style.color = '#e2e8f0';
                        st.classList.remove('active');
                    }
                });
            });

            s.addEventListener('mouseenter', () => {
                const val = parseInt(s.dataset.val);
                stars.forEach((st, i) => {
                    if (i < val) st.style.color = '#fbbf24';
                });
            });

            s.addEventListener('mouseleave', () => {
                const currentVal = parseInt(document.getElementById('ratingVal').value) || 0;
                stars.forEach((st, i) => {
                    st.style.color = i < currentVal ? '#f59e0b' : '#e2e8f0';
                });
            });
        });

        function validateRating() {
            if(document.getElementById('ratingVal').value === '') {
                alert('Please select a star rating first.');
                return false;
            }
            return true;
        }
    </script>

    <script>
        document.querySelectorAll('a[href]').forEach(function(link){
            var href=link.getAttribute('href');
            if(!href||href.startsWith('#')||href.startsWith('javascript')||link.target==='_blank') return;
            link.addEventListener('click',function(e){
                var dest=link.href;
                if(dest&&dest!==window.location.href){
                    e.preventDefault();
                    document.body.style.transition='opacity 0.3s ease,transform 0.3s ease';
                    document.body.style.opacity='0';
                    document.body.style.transform='translateY(-8px)';
                    setTimeout(function(){window.location.href=dest;},280);
                }
            });
        });
    </script>
</body>
</html>
