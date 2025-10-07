import React from 'react';
import PageWrapper from '@/components/PageWrapper';
import { motion } from 'framer-motion';
import { Card, CardHeader, CardTitle, CardDescription, CardContent } from '@/components/ui/card';
import { Code, Layers, Layout, Globe, Server, Database, Settings, Package, TestTube, BookOpen, Rocket, Construction } from 'lucide-react';

const architecturalLayers = [
    { name: "Client", icon: <Code className="w-8 h-8 text-blue-400" />, rationale: "The user-facing component, where the experience begins." },
    { name: "HTML", icon: <Layers className="w-8 h-8 text-orange-400" />, rationale: "The structural skeleton of the content." },
    { name: "CSS", icon: <Layout className="w-8 h-8 text-teal-400" />, rationale: "The style and presentation; the aesthetic." },
    { name: "JavaScript (JS)", icon: <Globe className="w-8 h-8 text-yellow-400" />, rationale: "The dynamic, interactive energy of the application." },
    { name: "Web/File Server", icon: <Server className="w-8 h-8 text-slate-400" />, rationale: "The frontline workhorse that handles incoming requests." },
    { name: "Programming Model", icon: <Package className="w-8 h-8 text-purple-500" />, rationale: "The logic and business rules; the brain of the operation." },
    { name: "Data Sources", icon: <Database className="w-8 h-8 text-red-500" />, rationale: "The foundational data store; the application's heart." },
    { name: "Operating System", icon: <Settings className="w-8 h-8 text-gray-500" />, rationale: "The bedrock foundation upon which all server-side software runs." },
];

const operationalLayers = [
    { name: "Productivity & Admin", icon: <Construction className="w-8 h-8 text-amber-500" />, rationale: "The developer's tools and environment where work gets done." },
    { name: "Testing", icon: <TestTube className="w-8 h-8 text-green-500" />, rationale: "The quality assurance 'Go/No-Go' signal." },
    { name: "Documentation", icon: <BookOpen className="w-8 h-8 text-indigo-400" />, rationale: "The comprehensive guide ensuring clarity and maintainability." },
    { name: "Deployment & Maintenance", icon: <Rocket className="w-8 h-8 text-pink-500" />, rationale: "The CI/CD pipelines that move code to production." },
];

const LayerCard = ({ layer, index }) => (
    <motion.div
        initial={{ opacity: 0, y: 50 }}
        whileInView={{ opacity: 1, y: 0 }}
        viewport={{ once: true, amount: 0.5 }}
        transition={{ duration: 0.5, delay: index * 0.05 }}
    >
        <Card className="bg-gray-800/50 border-gray-700 text-white shadow-lg h-full hover:border-cyan-400/50 hover:bg-gray-800/80 transition-all duration-300 transform hover:-translate-y-1">
            <CardHeader className="flex flex-row items-center gap-4 pb-4">
                {layer.icon}
                <CardTitle className="text-xl font-bold text-cyan-300">{layer.name}</CardTitle>
            </CardHeader>
            <CardContent>
                <CardDescription className="text-gray-300">{layer.rationale}</CardDescription>
            </CardContent>
        </Card>
    </motion.div>
);

const StackSpecPage = () => {
    return (
        <PageWrapper
            title="The Stack Spec System"
            description="Explore httpstack's 12-Layer 'Stack Spec' System and the 'Become a Specifier' campaign."
        >
            <div className="container mx-auto px-6 py-16">
                <motion.section
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8 }}
                    className="text-center"
                >
                    <h1 className="text-5xl md:text-6xl font-extrabold mb-6 bg-clip-text text-transparent bg-gradient-to-r from-cyan-400 to-purple-500">
                        The 12-Layer 'Stack Spec' System
                    </h1>
                    <p className="text-lg md:text-xl text-gray-300 max-w-3xl mx-auto mb-16">
                        We categorize your stack into two distinct types for clarity and power: the core running application and the processes that support it.
                    </p>
                </motion.section>

                <section className="mb-20">
                    <h2 className="text-3xl md:text-4xl font-bold mb-8 text-center text-cyan-400">Architectural Layers (The Runtime Core)</h2>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                        {architecturalLayers.map((layer, index) => (
                            <LayerCard key={layer.name} layer={layer} index={index} />
                        ))}
                    </div>
                </section>

                <section className="mb-20">
                    <h2 className="text-3xl md:text-4xl font-bold mb-8 text-center text-cyan-400">Operational Layers (The Development Lifecycle)</h2>
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                        {operationalLayers.map((layer, index) => (
                            <LayerCard key={layer.name} layer={layer} index={index} />
                        ))}
                    </div>
                </section>

                <motion.section
                    initial={{ opacity: 0 }}
                    whileInView={{ opacity: 1 }}
                    viewport={{ once: true }}
                    transition={{ duration: 1 }}
                    className="bg-gray-800/50 border border-purple-500/30 rounded-2xl p-8 md:p-12 text-center"
                >
                    <h2 className="text-4xl md:text-5xl font-bold mb-6 bg-clip-text text-transparent bg-gradient-to-r from-purple-400 to-pink-500">
                        Become a Specifier
                    </h2>
                    <p className="text-lg md:text-xl text-gray-200 max-w-4xl mx-auto">
                        Stop just <span className="font-semibold text-cyan-400">using stacks</span>. Start <span className="font-semibold text-cyan-400">defining them</span>. A documented stack is a solved problem. A specified stack is an industry standard. This is your invitation to become an architect of the future of web development.
                    </p>
                </motion.section>
            </div>
        </PageWrapper>
    );
};

export default StackSpecPage;