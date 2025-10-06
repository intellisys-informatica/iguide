/**
 * Markdown Renderer Module
 * Handles loading and rendering Markdown files
 */

export class MarkdownRenderer {
    constructor() {
        this.marked = window.marked;
        this.hljs = window.hljs;
        this.configureMarked();
    }

    /**
     * Configure marked.js options
     */
    configureMarked() {
        if (!this.marked) {
            console.error('marked.js not loaded');
            return;
        }

        this.marked.setOptions({
            highlight: (code, lang) => {
                if (lang && this.hljs.getLanguage(lang)) {
                    try {
                        return this.hljs.highlight(code, { language: lang }).value;
                    } catch (err) {
                        console.error('Highlight error:', err);
                    }
                }
                return this.hljs.highlightAuto(code).value;
            },
            breaks: true,
            gfm: true
        });
    }

    /**
     * Load and render a Markdown file
     * @param {string} filePath - Path to the markdown file
     * @returns {Promise<string>} Rendered HTML
     */
    async loadAndRender(filePath) {
        try {
            const response = await fetch(filePath);
            if (!response.ok) {
                throw new Error(`Failed to load ${filePath}: ${response.status}`);
            }

            const markdown = await response.text();
            const html = this.render(markdown);
            return html;
        } catch (error) {
            console.error('Error loading markdown:', error);
            throw error;
        }
    }

    /**
     * Render Markdown to HTML
     * @param {string} markdown - Markdown content
     * @returns {string} Rendered HTML
     */
    render(markdown) {
        if (!this.marked) {
            return '<p>Markdown renderer not available</p>';
        }

        let html = this.marked.parse(markdown);

        // Post-process HTML
        html = this.addHeadingAnchors(html);
        html = this.wrapCodeBlocks(html);
        html = this.processAdmonitions(html);

        return html;
    }

    /**
     * Add anchor links to headings
     * @param {string} html - HTML content
     * @returns {string} Processed HTML
     */
    addHeadingAnchors(html) {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        const headings = doc.querySelectorAll('h1, h2, h3, h4, h5, h6');
        headings.forEach(heading => {
            const id = this.generateId(heading.textContent);
            heading.id = id;

            const anchor = doc.createElement('a');
            anchor.className = 'anchor';
            anchor.href = `#${id}`;
            anchor.textContent = '#';
            anchor.setAttribute('aria-label', `Link to ${heading.textContent}`);

            heading.insertBefore(anchor, heading.firstChild);
        });

        return doc.body.innerHTML;
    }

    /**
     * Wrap code blocks with header and copy button
     * @param {string} html - HTML content
     * @returns {string} Processed HTML
     */
    wrapCodeBlocks(html) {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        const codeBlocks = doc.querySelectorAll('pre > code');
        codeBlocks.forEach(code => {
            const pre = code.parentElement;

            // Detect language
            const langMatch = code.className.match(/language-(\w+)/);
            const lang = langMatch ? langMatch[1] : 'text';

            // Create wrapper
            const wrapper = doc.createElement('div');
            wrapper.className = 'code-block-wrapper';

            // Create header
            const header = doc.createElement('div');
            header.className = 'code-header';

            const langLabel = doc.createElement('span');
            langLabel.className = 'code-lang';
            langLabel.textContent = lang;

            const copyBtn = doc.createElement('button');
            copyBtn.className = 'copy-btn';
            copyBtn.textContent = 'Copiar';
            copyBtn.setAttribute('data-code', code.textContent);

            header.appendChild(langLabel);
            header.appendChild(copyBtn);

            // Wrap elements
            pre.parentNode.insertBefore(wrapper, pre);
            wrapper.appendChild(header);
            wrapper.appendChild(pre);
        });

        return doc.body.innerHTML;
    }

    /**
     * Process admonitions (note, tip, warning, danger)
     * @param {string} html - HTML content
     * @returns {string} Processed HTML
     */
    processAdmonitions(html) {
        const admonitionPattern = />\s*\[!(NOTE|TIP|WARNING|DANGER)\]\s*\n?>\s*(.*?)(?=\n(?!>)|$)/gis;

        return html.replace(admonitionPattern, (match, type, content) => {
            const typeMap = {
                'NOTE': { icon: 'ℹ️', title: 'Nota' },
                'TIP': { icon: '💡', title: 'Dica' },
                'WARNING': { icon: '⚠️', title: 'Atenção' },
                'DANGER': { icon: '🚨', title: 'Perigo' }
            };

            const { icon, title } = typeMap[type.toUpperCase()] || typeMap.NOTE;

            return `
                <div class="admonition ${type.toLowerCase()}">
                    <div class="admonition-title">${icon} ${title}</div>
                    <div class="admonition-content">${content.trim()}</div>
                </div>
            `;
        });
    }

    /**
     * Generate ID from text
     * @param {string} text - Text to convert
     * @returns {string} Generated ID
     */
    generateId(text) {
        return text
            .toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '') // Remove accents
            .replace(/[^\w\s-]/g, '') // Remove special chars
            .replace(/\s+/g, '-') // Replace spaces with hyphens
            .replace(/^-+|-+$/g, ''); // Remove leading/trailing hyphens
    }

    /**
     * Extract table of contents from HTML
     * @param {string} html - HTML content
     * @returns {Array} TOC items
     */
    extractTOC(html) {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        const headings = doc.querySelectorAll('h2, h3');
        const toc = [];

        headings.forEach(heading => {
            toc.push({
                id: heading.id,
                text: heading.textContent.replace('#', '').trim(),
                level: parseInt(heading.tagName.charAt(1))
            });
        });

        return toc;
    }

    /**
     * Search content in markdown text
     * @param {string} markdown - Markdown content
     * @param {string} query - Search query
     * @returns {Array} Search results with context
     */
    searchContent(markdown, query) {
        if (!query || query.length < 2) return [];

        const lines = markdown.split('\n');
        const results = [];
        const queryLower = query.toLowerCase();

        lines.forEach((line, index) => {
            const lineLower = line.toLowerCase();
            if (lineLower.includes(queryLower)) {
                // Get context (previous and next line)
                const context = [
                    lines[index - 1] || '',
                    line,
                    lines[index + 1] || ''
                ].filter(Boolean).join(' ');

                results.push({
                    line: index + 1,
                    text: line,
                    context: context.substring(0, 150) + '...'
                });
            }
        });

        return results;
    }
}

export default MarkdownRenderer;
