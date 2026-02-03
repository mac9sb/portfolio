import WebUI

struct Home: Document {
    var metadata: Metadata {
        Metadata(from: Application.baseMetadata)
    }

    var path: String? { "index" }

    var scripts: [Script]? {
        [
            Script {
                """
                document.addEventListener('DOMContentLoaded', function() {
                    function setupPagination(sectionId, itemClass, itemsPerPage) {
                        const items = document.querySelectorAll('.' + itemClass);
                        const buttons = document.querySelectorAll('.pagination-buttons-' + sectionId + ' .pagination-btn');
                        const counter = document.querySelector('.pagination-counter-' + sectionId);
                        const totalPages = Math.ceil(items.length / itemsPerPage);
                        let currentPage = 1;

                        function showPage(page) {
                            currentPage = page;
                            const start = (page - 1) * itemsPerPage;
                            const end = start + itemsPerPage;

                            items.forEach((item, index) => {
                                if (index >= start && index < end) {
                                    item.classList.remove('hidden');
                                    item.classList.add('page-visible');
                                } else {
                                    item.classList.add('hidden');
                                    item.classList.remove('page-visible');
                                }
                            });

                            // Update arrow button states
                            const leftArrow = document.querySelector('.pagination-left-' + sectionId);
                            const rightArrow = document.querySelector('.pagination-right-' + sectionId);

                            // Check if dark mode is active
                            const isDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                            const activeColor = isDark ? '#fafaf9' : 'black';
                            const disabledColor = '#a8a29e';

                            if (leftArrow) {
                                if (page > 1) {
                                    leftArrow.classList.remove('page-disabled');
                                    leftArrow.classList.add('page-active');
                                    leftArrow.style.cursor = 'pointer';
                                    leftArrow.style.color = activeColor;
                                } else {
                                    leftArrow.classList.remove('page-active');
                                    leftArrow.classList.add('page-disabled');
                                    leftArrow.style.cursor = 'not-allowed';
                                    leftArrow.style.color = disabledColor;
                                }
                            }

                            if (rightArrow) {
                                if (page < totalPages) {
                                    rightArrow.classList.remove('page-disabled');
                                    rightArrow.classList.add('page-active');
                                    rightArrow.style.cursor = 'pointer';
                                    rightArrow.style.color = activeColor;
                                } else {
                                    rightArrow.classList.remove('page-active');
                                    rightArrow.classList.add('page-disabled');
                                    rightArrow.style.cursor = 'not-allowed';
                                    rightArrow.style.color = disabledColor;
                                }
                            }



                            if (counter) {
                                const pageNum = String(page).padStart(2, '0');
                                const totalNum = String(totalPages).padStart(2, '0');
                                counter.textContent = 'page ' + pageNum + ' / ' + totalNum;
                            }
                        }

                        buttons.forEach((btn, index) => {
                            btn.addEventListener('click', function() {
                                showPage(index + 1);
                            });
                        });

                        // Add arrow button navigation
                        const leftArrow = document.querySelector('.pagination-left-' + sectionId);
                        const rightArrow = document.querySelector('.pagination-right-' + sectionId);

                        if (leftArrow) {
                            leftArrow.addEventListener('click', function() {
                                if (currentPage > 1) {
                                    showPage(currentPage - 1);
                                }
                            });
                        }

                        if (rightArrow) {
                            rightArrow.addEventListener('click', function() {
                                if (currentPage < totalPages) {
                                    showPage(currentPage + 1);
                                }
                            });
                        }
                    }

                    setupPagination('projects', 'project-item', 4);
                    setupPagination('logs', 'log-item', 3);

                    // Hero Canvas Effects
                    initHeroCanvas();

                });

                function initHeroCanvas() {
                    const canvas = document.getElementById('hero-canvas');
                    if (!canvas) return;

                    const ctx = canvas.getContext('2d');
                    let animationId;
                    let particles = [];
                    let mouse = { x: 0, y: 0 };

                    // Set canvas size
                    function resizeCanvas() {
                        const rect = canvas.parentElement.getBoundingClientRect();
                        canvas.width = rect.width;
                        canvas.height = rect.height;
                    }

                    // Particle class
                    class Particle {
                        constructor(x, y) {
                            this.x = x;
                            this.y = y;
                            this.size = Math.random() * 2 + 0.5;
                            this.speedX = Math.random() * 2 - 1;
                            this.speedY = Math.random() * 2 - 1;
                            this.life = 0;
                            this.maxLife = Math.random() * 200 + 100;
                            this.opacity = 0;
                            this.color = getComputedStyle(document.documentElement).getPropertyValue('--tw-ring-color') || '#000';
                        }

                        update() {
                            this.x += this.speedX;
                            this.y += this.speedY;
                            this.life++;

                            // Fade in and out
                            if (this.life < 20) {
                                this.opacity = this.life / 20;
                            } else if (this.life > this.maxLife - 20) {
                                this.opacity = (this.maxLife - this.life) / 20;
                            } else {
                                this.opacity = 1;
                            }

                            // Mouse attraction
                            const dx = mouse.x - this.x;
                            const dy = mouse.y - this.y;
                            const distance = Math.sqrt(dx * dx + dy * dy);
                            if (distance < 100) {
                                this.speedX += dx * 0.0001;
                                this.speedY += dy * 0.0001;
                            }

                            // Boundary check
                            if (this.x < 0 || this.x > canvas.width) this.speedX *= -1;
                            if (this.y < 0 || this.y > canvas.height) this.speedY *= -1;
                        }

                        draw() {
                            ctx.save();
                            ctx.globalAlpha = this.opacity;
                            ctx.fillStyle = this.color;
                            ctx.beginPath();
                            ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
                            ctx.fill();
                            ctx.restore();
                        }

                        isDead() {
                            return this.life >= this.maxLife;
                        }
                    }

                    // Geometric pattern class
                    class GeometricPattern {
                        constructor() {
                            this.x = Math.random() * canvas.width;
                            this.y = Math.random() * canvas.height;
                            this.rotation = 0;
                            this.rotationSpeed = (Math.random() - 0.5) * 0.02;
                            this.size = Math.random() * 30 + 10;
                            this.opacity = Math.random() * 0.3 + 0.1;
                            this.sides = Math.floor(Math.random() * 3) + 3; // 3-5 sides
                        }

                        update() {
                            this.rotation += this.rotationSpeed;

                            // Subtle movement
                            this.x += Math.sin(Date.now() * 0.001) * 0.5;
                            this.y += Math.cos(Date.now() * 0.001) * 0.5;
                        }

                        draw() {
                            ctx.save();
                            ctx.globalAlpha = this.opacity;
                            ctx.strokeStyle = this.color;
                            ctx.lineWidth = 1;
                            ctx.translate(this.x, this.y);
                            ctx.rotate(this.rotation);

                            ctx.beginPath();
                            for (let i = 0; i < this.sides; i++) {
                                const angle = (i / this.sides) * Math.PI * 2;
                                const x = Math.cos(angle) * this.size;
                                const y = Math.sin(angle) * this.size;
                                if (i === 0) ctx.moveTo(x, y);
                                else ctx.lineTo(x, y);
                            }
                            ctx.closePath();
                            ctx.stroke();
                            ctx.restore();
                        }
                    }

                    let patterns = [];

                    // Initialize patterns
                    function initPatterns() {
                        patterns = [];
                        for (let i = 0; i < 8; i++) {
                            patterns.push(new GeometricPattern());
                        }
                    }

                    // Animation loop
                    function animate() {
                        ctx.clearRect(0, 0, canvas.width, canvas.height);

                        // Update and draw particles
                        particles = particles.filter(particle => {
                            particle.update();
                            particle.draw();
                            return !particle.isDead();
                        });

                        // Update and draw patterns
                        patterns.forEach(pattern => {
                            pattern.update();
                            pattern.draw();
                        });

                        // Add new particles occasionally
                        if (Math.random() < 0.1) {
                            particles.push(new Particle(
                                Math.random() * canvas.width,
                                Math.random() * canvas.height
                            ));
                        }

                        animationId = requestAnimationFrame(animate);
                    }

                    // Mouse tracking
                    canvas.addEventListener('mousemove', (e) => {
                        const rect = canvas.getBoundingClientRect();
                        mouse.x = e.clientX - rect.left;
                        mouse.y = e.clientY - rect.top;
                    });

                    // Theme-aware colors
                    function updateTheme() {
                        const isDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                        const root = document.documentElement;

                        if (isDark) {
                            Particle.prototype.color = '#ffffff';
                            GeometricPattern.prototype.color = '#ffffff';
                        } else {
                            Particle.prototype.color = '#000000';
                            GeometricPattern.prototype.color = '#000000';
                        }
                    }

                    // Initialize
                    resizeCanvas();
                    initPatterns();
                    updateTheme();
                    animate();

                    // Event listeners
                    window.addEventListener('resize', () => {
                        resizeCanvas();
                        initPatterns();
                    });

                    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', updateTheme);

                    // Cleanup on page unload
                    window.addEventListener('beforeunload', () => {
                        if (animationId) {
                            cancelAnimationFrame(animationId);
                        }
                    });
                }
                """
            }
        ]
    }

    var body: some Markup {
        PageLayout {
            Hero()
            ProjectSection()
            LogSection()
        }
    }
}
