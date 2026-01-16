import WebUI

struct Home: Document {
    var metadata: Metadata {
        Metadata(from: PortfolioSite.baseMetadata)
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

                            buttons.forEach((btn, index) => {
                                if (index + 1 === page) {
                                    btn.classList.add('bg-black', 'text-white');
                                    btn.classList.remove('bg-white', 'text-black');
                                } else {
                                    btn.classList.remove('bg-black', 'text-white');
                                    btn.classList.add('bg-white', 'text-black');
                                }
                            });

                            if (counter) {
                                const pageNum = String(page).padStart(2, '0');
                                const totalNum = String(totalPages).padStart(2, '0');
                                counter.textContent = 'PAGE ' + pageNum + ' / ' + totalNum;
                            }
                        }

                        buttons.forEach((btn, index) => {
                            btn.addEventListener('click', function() {
                                showPage(index + 1);
                            });
                        });
                    }

                    setupPagination('projects', 'project-item', 4);
                    setupPagination('logs', 'log-item', 3);
                });
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