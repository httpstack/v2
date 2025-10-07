import React from 'react';
import { Code } from 'lucide-react';
import { Link } from 'react-router-dom';

const Footer = () => {
    return (
        <footer className="bg-gray-950/50 border-t border-gray-800">
            <div className="container mx-auto px-6 py-8">
                <div className="flex flex-col md:flex-row justify-between items-center">
                    <div className="flex items-center gap-2 text-xl font-bold text-white mb-4 md:mb-0">
                        <Code className="w-7 h-7 text-cyan-400" />
                        <span>httpstack</span>
                    </div>
                    <div className="text-center md:text-right">
                        <p className="text-gray-400">&copy; {new Date().getFullYear()} httpstack. All rights reserved.</p>
                        <p className="text-sm text-gray-500 mt-1">Connecting Developers, Empowering Businesses.</p>
                    </div>
                </div>
            </div>
        </footer>
    );
};

export default Footer;