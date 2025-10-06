/**
 * Navigation Module
 * Handles navigation menu, routing, and UI state
 */

export class Navigation {
    constructor(manifestPath = 'docs/manifest.json') {
        this.manifestPath = manifestPath;
        this.manifest = null;
        this.currentDoc = null;
        this.elements = {
            navMenu: document.getElementById('navMenu'),
            content: document.getElementById('content'),
            breadcrumb: document.getElementById('breadcrumb'),
            toc: document.getElementById('toc'),
            tocContent: document.getElementById('tocContent'),
            sidebar: document.getElementById('sidebar'),
            menuToggle: document.getElementById('menuToggle')
        };

        this.setupMenuToggle();
    }

    /**
     * Load manifest file
     * @returns {Promise<Object>} Manifest data
     */
    async loadManifest() {
        try {
            const response = await fetch(this.manifestPath);
            if (!response.ok) {
                throw new Error(`Failed to load manifest: ${response.status}`);
            }

            this.manifest = await response.json();
            return this.manifest;
        } catch (error) {
            console.error('Error loading manifest:', error);
            throw error;
        }
    }

    /**
     * Render navigation menu
     */
    renderMenu() {
        if (!this.manifest || !this.elements.navMenu) return;

        const menuHTML = this.manifest.categories.map(category => {
            const itemsHTML = category.docs.map(doc => {
                const isActive = this.currentDoc?.id === doc.id ? 'active' : '';
                return `
                    <a href="#doc/${doc.id}" class="nav-item ${isActive}" data-doc-id="${doc.id}">
                        ${doc.title}
                    </a>
                `;
            }).join('');

            return `
                <div class="nav-category" data-category-id="${category.id}">
                    <div class="nav-category-header">
                        <span class="nav-category-icon">${category.icon || '📄'}</span>
                        <span class="nav-category-title">${category.title}</span>
                        <span class="nav-category-toggle">▼</span>
                    </div>
                    <div class="nav-category-items">
                        ${itemsHTML}
                    </div>
                </div>
            `;
        }).join('');

        this.elements.navMenu.innerHTML = menuHTML;
        this.setupCategoryToggles();
        this.setupNavLinks();
    }

    /**
     * Setup category collapse/expand
     */
    setupCategoryToggles() {
        const categoryHeaders = this.elements.navMenu.querySelectorAll('.nav-category-header');

        categoryHeaders.forEach(header => {
            header.addEventListener('click', (e) => {
                const category = header.parentElement;
                category.classList.toggle('collapsed');

                // Save state to localStorage
                const categoryId = category.dataset.categoryId;
                const isCollapsed = category.classList.contains('collapsed');
                localStorage.setItem(`category-${categoryId}`, isCollapsed);
            });

            // Restore state from localStorage
            const category = header.parentElement;
            const categoryId = category.dataset.categoryId;
            const savedState = localStorage.getItem(`category-${categoryId}`);
            if (savedState === 'true') {
                category.classList.add('collapsed');
            }
        });
    }

    /**
     * Setup navigation link handlers
     */
    setupNavLinks() {
        const navLinks = this.elements.navMenu.querySelectorAll('.nav-item');

        navLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const docId = link.dataset.docId;
                this.navigateToDoc(docId);

                // Close mobile menu
                if (window.innerWidth <= 768) {
                    this.elements.sidebar.classList.remove('active');
                }
            });
        });
    }

    /**
     * Navigate to a document
     * @param {string} docId - Document ID
     */
    async navigateToDoc(docId) {
        const doc = this.findDocById(docId);
        if (!doc) {
            console.error(`Document not found: ${docId}`);
            return;
        }

        this.currentDoc = doc;

        // Update URL hash
        window.location.hash = `doc/${docId}`;

        // Update active state in menu
        this.updateActiveNavItem(docId);

        // Update breadcrumb
        this.updateBreadcrumb(doc);

        // Dispatch event for content loading
        window.dispatchEvent(new CustomEvent('navigate', { detail: { doc } }));
    }

    /**
     * Find document by ID
     * @param {string} docId - Document ID
     * @returns {Object|null} Document object
     */
    findDocById(docId) {
        for (const category of this.manifest.categories) {
            const doc = category.docs.find(d => d.id === docId);
            if (doc) {
                return {
                    ...doc,
                    category: {
                        id: category.id,
                        title: category.title,
                        icon: category.icon
                    }
                };
            }
        }
        return null;
    }

    /**
     * Update active navigation item
     * @param {string} docId - Document ID
     */
    updateActiveNavItem(docId) {
        // Remove all active classes
        this.elements.navMenu.querySelectorAll('.nav-item').forEach(item => {
            item.classList.remove('active');
        });

        // Add active class to current item
        const activeItem = this.elements.navMenu.querySelector(`[data-doc-id="${docId}"]`);
        if (activeItem) {
            activeItem.classList.add('active');

            // Ensure parent category is expanded
            const category = activeItem.closest('.nav-category');
            if (category) {
                category.classList.remove('collapsed');
            }
        }
    }

    /**
     * Update breadcrumb
     * @param {Object} doc - Document object
     */
    updateBreadcrumb(doc) {
        if (!this.elements.breadcrumb) return;

        const breadcrumbHTML = `
            <a href="#" data-doc="home">Home</a>
            <span class="breadcrumb-separator"></span>
            <span>${doc.category.icon} ${doc.category.title}</span>
            <span class="breadcrumb-separator"></span>
            <span>${doc.title}</span>
        `;

        this.elements.breadcrumb.innerHTML = breadcrumbHTML;

        // Setup home link
        const homeLink = this.elements.breadcrumb.querySelector('[data-doc="home"]');
        if (homeLink) {
            homeLink.addEventListener('click', (e) => {
                e.preventDefault();
                this.navigateHome();
            });
        }
    }

    /**
     * Navigate to home page
     */
    navigateHome() {
        window.location.hash = '';
        this.currentDoc = null;

        // Update breadcrumb
        if (this.elements.breadcrumb) {
            this.elements.breadcrumb.innerHTML = '<a href="#" data-doc="home">Home</a>';
        }

        // Clear active state
        this.elements.navMenu.querySelectorAll('.nav-item').forEach(item => {
            item.classList.remove('active');
        });

        // Clear TOC
        if (this.elements.toc) {
            this.elements.toc.style.display = 'none';
        }

        // Dispatch event
        window.dispatchEvent(new CustomEvent('navigate-home'));
    }

    /**
     * Render table of contents
     * @param {Array} tocItems - TOC items
     */
    renderTOC(tocItems) {
        if (!this.elements.tocContent || !tocItems || tocItems.length === 0) {
            if (this.elements.toc) {
                this.elements.toc.style.display = 'none';
            }
            return;
        }

        this.elements.toc.style.display = 'block';

        const tocHTML = tocItems.map(item => {
            const indent = item.level === 3 ? 'margin-left: 1rem;' : '';
            return `<a href="#${item.id}" style="${indent}">${item.text}</a>`;
        }).join('');

        this.elements.tocContent.innerHTML = tocHTML;

        // Setup TOC link handlers
        this.setupTOCLinks();

        // Setup scroll spy
        this.setupScrollSpy(tocItems);
    }

    /**
     * Setup TOC link handlers
     */
    setupTOCLinks() {
        const tocLinks = this.elements.tocContent.querySelectorAll('a');

        tocLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const targetId = link.getAttribute('href').substring(1);
                const targetElement = document.getElementById(targetId);

                if (targetElement) {
                    targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' });

                    // Update active state
                    tocLinks.forEach(l => l.classList.remove('active'));
                    link.classList.add('active');
                }
            });
        });
    }

    /**
     * Setup scroll spy for TOC
     * @param {Array} tocItems - TOC items
     */
    setupScrollSpy(tocItems) {
        const observer = new IntersectionObserver(
            (entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const id = entry.target.id;
                        const tocLinks = this.elements.tocContent.querySelectorAll('a');

                        tocLinks.forEach(link => {
                            if (link.getAttribute('href') === `#${id}`) {
                                tocLinks.forEach(l => l.classList.remove('active'));
                                link.classList.add('active');
                            }
                        });
                    }
                });
            },
            { rootMargin: '-100px 0px -66%' }
        );

        // Observe all heading elements
        tocItems.forEach(item => {
            const element = document.getElementById(item.id);
            if (element) {
                observer.observe(element);
            }
        });
    }

    /**
     * Setup mobile menu toggle
     */
    setupMenuToggle() {
        if (!this.elements.menuToggle || !this.elements.sidebar) return;

        this.elements.menuToggle.addEventListener('click', () => {
            this.elements.sidebar.classList.toggle('active');
        });

        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (window.innerWidth <= 768) {
                const isClickInsideSidebar = this.elements.sidebar.contains(e.target);
                const isClickOnToggle = this.elements.menuToggle.contains(e.target);

                if (!isClickInsideSidebar && !isClickOnToggle) {
                    this.elements.sidebar.classList.remove('active');
                }
            }
        });
    }

    /**
     * Handle browser back/forward navigation
     */
    setupHashNavigation() {
        window.addEventListener('hashchange', () => {
            const hash = window.location.hash.substring(1);

            if (hash.startsWith('doc/')) {
                const docId = hash.substring(4);
                this.navigateToDoc(docId);
            } else if (hash === '') {
                this.navigateHome();
            }
        });

        // Handle initial hash
        const initialHash = window.location.hash.substring(1);
        if (initialHash.startsWith('doc/')) {
            const docId = initialHash.substring(4);
            this.navigateToDoc(docId);
        }
    }

    /**
     * Get all documents for search
     * @returns {Array} All documents
     */
    getAllDocs() {
        if (!this.manifest) return [];

        const allDocs = [];
        this.manifest.categories.forEach(category => {
            category.docs.forEach(doc => {
                allDocs.push({
                    ...doc,
                    category: {
                        id: category.id,
                        title: category.title,
                        icon: category.icon
                    }
                });
            });
        });

        return allDocs;
    }
}

export default Navigation;
