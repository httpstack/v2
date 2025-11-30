import React from 'react';
import PageWrapper from '@/components/PageWrapper';
import { motion } from 'framer-motion';
import { Button } from '@/components/ui/button';
import { Link } from 'react-router-dom';
import { ArrowRight, Layers, Users, Zap } from 'lucide-react';

const HomePage = () => {
  return (
    <PageWrapper title="httpstack - Home" description="Community Driven, Commercially Focused. Define, share, and build better software stacks.">
      {/* Hero Section */}
      <section className="relative text-white overflow-hidden bg-gray-900">
        <div className="absolute inset-0 bg-gradient-to-br from-gray-900 via-gray-900 to-cyan-900/30 opacity-70 z-10"></div>
        <div className="absolute inset-0 z-0">
          <div className="absolute h-full w-full bg-[radial-gradient(#2dd4bf_1px,transparent_1px)] [background-size:32px_32px] [mask-image:radial-gradient(ellipse_50%_50%_at_50%_50%,#000_70%,transparent_100%)] opacity-20"></div>
        </div>
        <div className="container mx-auto px-6 py-32 md:py-48 relative z-20 text-center">
          <motion.h1 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
            className="text-4xl md:text-6xl font-extrabold tracking-tight drop-shadow-lg"
          >
            Define Your Stack. <span className="block md:inline bg-clip-text text-transparent bg-gradient-to-r from-cyan-400 to-purple-500">Own Your Architecture.</span>
          </motion.h1>
          <motion.p 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.2 }}
            className="mt-6 text-lg md:text-xl max-w-3xl mx-auto text-gray-300 drop-shadow-md"
          >
            httpstack helps you create, document, and share verifiable software stacks. Go beyond READMEs with the 12-Layer Stack Spec system.
          </motion.p>
          <motion.div 
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.4 }}
            className="mt-10 flex justify-center gap-4"
          >
            <Button asChild size="lg" className="bg-cyan-500 hover:bg-cyan-600 text-white font-bold py-3 px-8 rounded-full shadow-lg transform hover:scale-105 transition-transform">
              <Link to="/stack-spec">
                Explore the System <ArrowRight className="ml-2 h-5 w-5" />
              </Link>
            </Button>
            <Button asChild size="lg" variant="outline" className="font-bold py-3 px-8 rounded-full shadow-lg transform hover:scale-105 transition-transform border-cyan-400 text-cyan-400 hover:bg-cyan-400/10 hover:text-cyan-300">
              <Link to="/register">Join Now</Link>
            </Button>
          </motion.div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 md:py-28 bg-gray-900">
        <div className="container mx-auto px-6 text-center">
          <h2 className="text-3xl md:text-4xl font-bold mb-12">Why <span className="text-cyan-400">httpstack</span>?</h2>
          <div className="grid md:grid-cols-3 gap-8">
            <motion.div initial={{ opacity: 0, y: 50 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ duration: 0.5, delay: 0 }}>
              <div className="p-8 bg-gray-800/50 rounded-xl shadow-lg border border-gray-700 h-full">
                <div className="flex justify-center items-center mb-4 h-16 w-16 rounded-full bg-cyan-500/10 mx-auto">
                  <Layers className="h-8 w-8 text-cyan-400" />
                </div>
                <h3 className="text-2xl font-bold mb-4">Standardize</h3>
                <p className="text-gray-400">Create a single source of truth for your entire tech stack, reducing ambiguity and onboarding time.</p>
              </div>
            </motion.div>
            <motion.div initial={{ opacity: 0, y: 50 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ duration: 0.5, delay: 0.2 }}>
              <div className="p-8 bg-gray-800/50 rounded-xl shadow-lg border border-gray-700 h-full">
                <div className="flex justify-center items-center mb-4 h-16 w-16 rounded-full bg-purple-500/10 mx-auto">
                  <Users className="h-8 w-8 text-purple-400" />
                </div>
                <h3 className="text-2xl font-bold mb-4">Collaborate</h3>
                <p className="text-gray-400">Share your specifications with the community, discover innovative stacks, and contribute to open standards.</p>
              </div>
            </motion.div>
            <motion.div initial={{ opacity: 0, y: 50 }} whileInView={{ opacity: 1, y: 0 }} viewport={{ once: true }} transition={{ duration: 0.5, delay: 0.4 }}>
              <div className="p-8 bg-gray-800/50 rounded-xl shadow-lg border border-gray-700 h-full">
                <div className="flex justify-center items-center mb-4 h-16 w-16 rounded-full bg-green-500/10 mx-auto">
                  <Zap className="h-8 w-8 text-green-400" />
                </div>
                <h3 className="text-2xl font-bold mb-4">Validate</h3>
                <p className="text-gray-400">Leverage our tools to check for compatibility and maintain documentation integrity automatically.</p>
              </div>
            </motion.div>
          </div>
        </div>
      </section>
    </PageWrapper>
  );
};

export default HomePage;