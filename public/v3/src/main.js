document.addEventListener('DOMContentLoaded', () => {
    // --- Theme Toggle ---
    const themeToggle = document.getElementById('theme-toggle');
    const sunIcon = document.getElementById('theme-icon-sun');
    const moonIcon = document.getElementById('theme-icon-moon');
    const html = document.documentElement;

    const applyTheme = (theme) => {
        if (theme === 'dark') {
            html.classList.add('dark');
            sunIcon?.classList.remove('hidden');
            moonIcon?.classList.add('hidden');
        } else {
            html.classList.remove('dark');
            sunIcon?.classList.add('hidden');
            moonIcon?.classList.remove('hidden');
        }
    };

    const currentTheme = localStorage.getItem('theme') || 'dark';
    applyTheme(currentTheme);

    themeToggle?.addEventListener('click', () => {
        const newTheme = html.classList.contains('dark') ? 'light' : 'dark';
        localStorage.setItem('theme', newTheme);
        applyTheme(newTheme);
    });
    
    // --- Mobile Menu ---
    const menuToggle = document.getElementById('menu-toggle');
    const mobileMenu = document.getElementById('mobile-menu');
    const menuOpenIcon = document.getElementById('menu-open-icon');
    const menuCloseIcon = document.getElementById('menu-close-icon');

    menuToggle?.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
        menuOpenIcon.classList.toggle('hidden');
        menuCloseIcon.classList.toggle('hidden');
    });

    // --- Sticky Header ---
    const header = document.getElementById('header');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 10) {
            header?.classList.add('bg-white', 'dark:bg-gray-800', 'shadow-md');
        } else {
            header?.classList.remove('bg-white', 'dark:bg-gray-800', 'shadow-md');
        }
    });

    // --- Slideshow ---
    const slideshowImages = document.querySelectorAll('.slideshow-image');
    if (slideshowImages.length > 0) {
        let currentImageIndex = 0;
        slideshowImages.forEach(img => img.style.opacity = 0);
        slideshowImages[0].style.opacity = 1;

        setInterval(() => {
            slideshowImages[currentImageIndex].style.opacity = 0;
            currentImageIndex = (currentImageIndex + 1) % slideshowImages.length;
            slideshowImages[currentImageIndex].style.opacity = 1;
        }, 5000);
    }

    // --- Resume Page Logic ---
    const viewLightboxBtn = document.getElementById('view-lightbox');
    const closeLightboxBtn = document.getElementById('close-lightbox');
    const lightbox = document.getElementById('lightbox');
    const downloadButton = document.getElementById('download-button');
    const downloadDropdown = document.getElementById('download-dropdown');

    viewLightboxBtn?.addEventListener('click', () => lightbox?.classList.remove('hidden'));
    closeLightboxBtn?.addEventListener('click', () => lightbox?.classList.add('hidden'));
    lightbox?.addEventListener('click', (e) => {
        if (e.target === lightbox) lightbox.classList.add('hidden');
    });

    downloadButton?.addEventListener('click', (e) => {
        e.stopPropagation();
        downloadDropdown?.classList.toggle('hidden');
    });
    
    document.addEventListener('click', () => {
        downloadDropdown?.classList.add('hidden');
    });

    document.querySelectorAll('.download-option').forEach(option => {
        option.addEventListener('click', (e) => {
            e.preventDefault();
            const format = e.target.dataset.format;
            showToast(`🚧 Download (${format})`, "This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀");
        });
    });
    
    // --- Login/Register Forms ---
    const loginForm = document.getElementById('login-form');
    const registerForm = document.getElementById('register-form');
    
    loginForm?.addEventListener('submit', (e) => {
        e.preventDefault();
        showToast("🚧 Login Attempted", "This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀");
    });
    
    registerForm?.addEventListener('submit', (e) => {
        e.preventDefault();
        showToast("🚧 Registration Attempted", "This feature isn't implemented yet—but don't worry! You can request it in your next prompt! 🚀");
    });

    // --- Toast Notification ---
    function showToast(title, description) {
        const toastContainer = document.getElementById('toast-container');
        if (!toastContainer) return;

        const toast = document.createElement('div');
        toast.className = 'bg-gray-800 text-white p-4 rounded-lg shadow-lg animate-fade-in-up';
        toast.innerHTML = `<h3 class="font-bold">${title}</h3><p>${description}</p>`;
        
        toastContainer.appendChild(toast);
        
        setTimeout(() => {
            toast.classList.add('animate-fade-out-down');
            setTimeout(() => toast.remove(), 500);
        }, 5000);
    }
});