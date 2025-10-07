import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Menu, X, Code, Sun, Moon } from 'lucide-react';
import { NavLink, Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { useTheme } from '@/hooks/useTheme';

const navLinks = [
    { to: '/', label: 'Home' },
    { to: '/stack-spec', label: 'Stack Spec' },
    { to: '/services', label: 'Services' },
    { to: '/resume', label: 'Resume' },
];

const Header = () => {
    const [isScrolled, setIsScrolled] = useState(false);
    const [isMenuOpen, setIsMenuOpen] = useState(false);
    const { theme, setTheme } = useTheme();

    const handleLinkClick = () => {
        setIsMenuOpen(false);
    };

    useEffect(() => {
        const handleScroll = () => {
            setIsScrolled(window.scrollY > 10);
        };
        window.addEventListener('scroll', handleScroll);
        return () => window.removeEventListener('scroll', handleScroll);
    }, []);

    const activeLinkStyle = {
        color: '#2dd4bf', // tailwind cyan-400
    };

    return (
        <>
            <motion.header
                className={`sticky top-0 left-0 right-0 z-50 transition-colors duration-300 ${isScrolled ? 'bg-gray-900/80 dark:bg-gray-950/80 backdrop-blur-lg shadow-lg' : 'bg-transparent'}`}
                initial={{ y: -100 }}
                animate={{ y: 0 }}
                transition={{ duration: 0.5 }}
            >
                <div className="container mx-auto px-6 py-4 flex justify-between items-center">
                    <Link to="/" onClick={handleLinkClick} className="flex items-center gap-2 text-2xl font-bold text-white hover:text-cyan-400 transition-colors">
                        <Code className="w-8 h-8 text-cyan-400" />
                        <span>httpstack</span>
                    </Link>

                    <nav className="hidden md:flex items-center space-x-8">
                        {navLinks.map((link) => (
                            <NavLink 
                                key={link.to} 
                                to={link.to} 
                                style={({ isActive }) => isActive ? activeLinkStyle : undefined}
                                className="text-lg font-medium text-gray-300 hover:text-cyan-400 transition-all duration-300 relative group"
                            >
                                {link.label}
                                <span className="absolute bottom-0 left-0 w-0 h-0.5 bg-cyan-400 transition-all duration-300 group-hover:w-full"></span>
                            </NavLink>
                        ))}
                    </nav>

                    <div className="flex items-center gap-2">
                         <div className="hidden md:flex items-center gap-2">
                            <Button asChild variant="ghost" className="text-white hover:bg-gray-700 hover:text-white">
                                <Link to="/login">Login</Link>
                            </Button>
                            <Button asChild className="bg-cyan-500 hover:bg-cyan-600 text-white">
                                <Link to="/register">Register</Link>
                            </Button>
                        </div>
                        <Button variant="ghost" size="icon" onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')} className="text-white hover:bg-gray-700">
                            <AnimatePresence mode="wait" initial={false}>
                                <motion.div
                                    key={theme}
                                    initial={{ y: -20, opacity: 0 }}
                                    animate={{ y: 0, opacity: 1 }}
                                    exit={{ y: 20, opacity: 0 }}
                                    transition={{ duration: 0.2 }}
                                >
                                    {theme === 'dark' ? <Sun /> : <Moon />}
                                </motion.div>
                            </AnimatePresence>
                        </Button>
                        <div className="md:hidden">
                            <button onClick={() => setIsMenuOpen(!isMenuOpen)} className="text-white p-2">
                                {isMenuOpen ? <X size={28} /> : <Menu size={28} />}
                            </button>
                        </div>
                    </div>
                </div>
            </motion.header>

            <AnimatePresence>
                {isMenuOpen && (
                    <motion.div
                        initial={{ opacity: 0, height: 0 }}
                        animate={{ opacity: 1, height: 'auto' }}
                        exit={{ opacity: 0, height: 0 }}
                        transition={{ duration: 0.3, ease: 'easeInOut' }}
                        className="fixed top-[80px] left-0 right-0 bg-gray-900/95 backdrop-blur-xl z-40 p-5 md:hidden overflow-hidden"
                    >
                        <nav className="flex flex-col items-center space-y-6">
                            {navLinks.map((link) => (
                                <NavLink 
                                    key={link.to} 
                                    to={link.to} 
                                    onClick={handleLinkClick}
                                    style={({ isActive }) => isActive ? activeLinkStyle : undefined}
                                    className="text-2xl font-semibold text-gray-200 hover:text-cyan-400 transition-colors"
                                >
                                    {link.label}
                                </NavLink>
                            ))}
                            <div className="border-t border-gray-700 w-full my-4"></div>
                            <div className="flex flex-col items-center gap-4 w-full">
                                <Button asChild variant="outline" className="w-full text-white border-cyan-400 hover:bg-cyan-400/10 hover:text-cyan-300" onClick={handleLinkClick}>
                                    <Link to="/login">Login</Link>
                                </Button>
                                <Button asChild className="w-full bg-cyan-500 hover:bg-cyan-600 text-white" onClick={handleLinkClick}>
                                    <Link to="/register">Register</Link>
                                </Button>
                            </div>
                        </nav>
                    </motion.div>
                )}
            </AnimatePresence>
        </>
    );
};

export default Header;