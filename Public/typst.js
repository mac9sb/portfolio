(function() {
    const copyButtonClass = 'typst-copy-btn';
    const copiedClass = 'copied';
    const svgCopy = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>';
    const svgCheck = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>';

    document.querySelectorAll('.' + copyButtonClass).forEach(function(btn) {
        btn.addEventListener('click', function() {
            const pre = this.closest('.typst-code-block-container').querySelector('pre');
            const code = pre.querySelector('code');
            const text = code.textContent;

            navigator.clipboard.writeText(text).then(function() {
                const span = btn.querySelector('span');
                const svg = btn.querySelector('svg');
                if (span) span.textContent = 'Copied!';
                if (svg) svg.outerHTML = svgCheck;
                btn.classList.add(copiedClass);
                setTimeout(function() {
                    if (span) span.textContent = 'Copy';
                    if (svg) svg.outerHTML = svgCopy;
                    btn.classList.remove(copiedClass);
                }, 2000);
            });
        });
    });
})();