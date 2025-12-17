-- Seed Questions for jQuery, Bootstrap, Node.js
-- Assumes layers are already inserted with ids:
-- 3 = CSS, 4 = JavaScript, 6 = Programming Model

LOCK TABLES `questions` WRITE;
ALTER TABLE `questions` DISABLE KEYS;

-- ====================
-- jQuery (layer_id = 4)
-- ====================
INSERT INTO `questions` (layer_id, question_category, question_text, is_required) VALUES
(4,'Core Info','What is jQuery in one sentence?',1),
(4,'Core Info','Why was jQuery created, and what problem did it originally solve?',1),
(4,'Core Info','What browsers does jQuery support?',1),
(4,'Core Info','What is the current status of jQuery (active use, maintenance, decline)?',0),

(4,'Setup & Installation','How do you add jQuery to a project (CDN, npm, self-hosted)?',1),
(4,'Setup & Installation','What’s the difference between slim and full builds of jQuery?',1),
(4,'Setup & Installation','How do you verify jQuery is loaded and available in the browser?',1),
(4,'Setup & Installation','How do you avoid conflicts with other libraries (noConflict mode)?',0),

(4,'Role in Application','What are the main use cases for jQuery today?',1),
(4,'Role in Application','How does jQuery handle DOM selection compared to vanilla JS?',1),
(4,'Role in Application','How does jQuery simplify event handling?',1),
(4,'Role in Application','What animation utilities does jQuery provide?',0),
(4,'Role in Application','What form-handling helpers does jQuery have?',0),
(4,'Role in Application','How does jQuery interact with AJAX (before fetch/axios)?',1),

(4,'Connectivity','How does jQuery’s $.ajax() compare to fetch()? ',1),
(4,'Connectivity','What shorthand AJAX helpers exist ($.get, $.post)?',1),
(4,'Connectivity','How does jQuery handle JSON responses?',1),
(4,'Connectivity','How do you intercept and modify global AJAX behavior?',0),

(4,'Common Gotchas','What performance pitfalls exist with jQuery selectors?',1),
(4,'Common Gotchas','Why should you avoid using jQuery for heavy animations?',0),
(4,'Common Gotchas','What compatibility issues arise when mixing jQuery with modern frameworks (React/Vue)?',1),
(4,'Common Gotchas','How can overuse of jQuery plugins cause maintainability issues?',1),

(4,'Wisdom & Tips','When should you use vanilla JS instead of jQuery?',1),
(4,'Wisdom & Tips','How can you migrate away from jQuery gracefully?',1),
(4,'Wisdom & Tips','What modern APIs replace most jQuery features?',1),
(4,'Wisdom & Tips','What are some must-know jQuery methods every dev should learn?',1),
(4,'Wisdom & Tips','How does jQuery plugin architecture work?',0),
(4,'Wisdom & Tips','How do you debug jQuery-heavy code?',1),
(4,'Wisdom & Tips','What is the lifecycle of a jQuery project (legacy → modernization)?',0),
(4,'Wisdom & Tips','What security considerations apply when using jQuery and plugins?',1);

-- ====================
-- Bootstrap (layer_id = 3)
-- ====================
INSERT INTO `questions` (layer_id, question_category, question_text, is_required) VALUES
(3,'Core Info','What is Bootstrap in one sentence?',1),
(3,'Core Info','Who maintains Bootstrap, and what is its release history?',1),
(3,'Core Info','What versions are most commonly in use today?',1),
(3,'Core Info','What problem does Bootstrap solve for developers?',1),

(3,'Setup & Installation','How do you install Bootstrap (CDN, npm, bundler)?',1),
(3,'Setup & Installation','What’s the difference between compiled CSS and source Sass files?',1),
(3,'Setup & Installation','How do you include Bootstrap JS, and what dependencies exist (Popper, etc.)?',1),
(3,'Setup & Installation','How do you customize Bootstrap variables via Sass?',1),

(3,'Role in Application','How does Bootstrap’s grid system work?',1),
(3,'Role in Application','What responsive breakpoints exist, and how are they applied?',1),
(3,'Role in Application','What are utility classes, and why are they important?',1),
(3,'Role in Application','How does Bootstrap handle typography and icons?',1),
(3,'Role in Application','What are Bootstrap components (buttons, navbars, modals, etc.)?',1),
(3,'Role in Application','How do you override Bootstrap defaults safely?',1),

(3,'Connectivity','How does Bootstrap integrate with JavaScript frameworks like React/Angular?',1),
(3,'Connectivity','What role does Popper.js play in Bootstrap components?',1),
(3,'Connectivity','How do you extend Bootstrap with custom themes or plugins?',1),
(3,'Connectivity','What CDN services host Bootstrap reliably?',0),

(3,'Common Gotchas','What are the downsides of heavy Bootstrap usage (bloat, sameness)?',1),
(3,'Common Gotchas','What common accessibility pitfalls exist with Bootstrap?',1),
(3,'Common Gotchas','How does version mismatch (v4 vs v5) cause migration issues?',1),
(3,'Common Gotchas','What issues arise when combining Bootstrap with Tailwind or custom CSS frameworks?',1),

(3,'Wisdom & Tips','When should you use Bootstrap vs writing custom CSS?',1),
(3,'Wisdom & Tips','How do you reduce unused Bootstrap CSS for performance?',1),
(3,'Wisdom & Tips','How do you handle theming (light/dark, branding)?',1),
(3,'Wisdom & Tips','What are best practices for customizing Bootstrap without breaking updates?',1),
(3,'Wisdom & Tips','What role do Bootstrap Icons and third-party icon packs play?',0),
(3,'Wisdom & Tips','How do you debug layout issues in Bootstrap grids?',1),
(3,'Wisdom & Tips','What is the role of Bootstrap in rapid prototyping?',1),
(3,'Wisdom & Tips','What future direction is Bootstrap heading toward (utility-first, modern CSS)?',1);

-- ====================
-- Node.js (layer_id = 6)
-- ====================
INSERT INTO `questions` (layer_id, question_category, question_text, is_required) VALUES
(6,'Core Info','What is Node.js in one sentence?',1),
(6,'Core Info','What runtime powers Node.js, and how does it differ from browsers?',1),
(6,'Core Info','What are the main strengths of Node.js?',1),
(6,'Core Info','What are the weaknesses or limitations of Node.js?',1),

(6,'Setup & Installation','How do you install Node.js (binary, package managers, nvm)?',1),
(6,'Setup & Installation','What is the difference between LTS and Current releases?',1),
(6,'Setup & Installation','How do you manage multiple Node.js versions?',1),
(6,'Setup & Installation','What are npm and npx, and how are they used?',1),

(6,'Role in Application','What are typical use cases for Node.js (APIs, CLI tools, servers)?',1),
(6,'Role in Application','What is the role of the event loop in Node.js?',1),
(6,'Role in Application','How does Node.js handle concurrency (callbacks, promises, async/await)?',1),
(6,'Role in Application','How are Node modules structured and imported (require vs import)?',1),
(6,'Role in Application','How does Node.js differ from frontend JavaScript environments?',1),
(6,'Role in Application','What are built-in Node modules (fs, http, path, etc.)?',1),

(6,'Connectivity','How does Node.js handle HTTP requests and responses?',1),
(6,'Connectivity','How do you connect Node.js to databases (SQL, NoSQL)?',1),
(6,'Connectivity','What frameworks exist for building servers in Node.js (Express, Fastify)?',1),
(6,'Connectivity','How do you use Node.js for real-time apps (WebSockets, Socket.io)?',1),

(6,'Common Gotchas','What are common performance pitfalls in Node.js apps?',1),
(6,'Common Gotchas','Why can blocking code freeze a Node.js server?',1),
(6,'Common Gotchas','How do you prevent callback hell in Node.js?',1),
(6,'Common Gotchas','What are common memory leak sources in Node.js apps?',0),

(6,'Wisdom & Tips','What logging and debugging tools are best for Node.js?',1),
(6,'Wisdom & Tips','How do you manage environment variables in Node.js?',1),
(6,'Wisdom & Tips','What security concerns are unique to Node.js?',1),
(6,'Wisdom & Tips','How do you handle error management in async code?',1),
(6,'Wisdom & Tips','What are best practices for structuring a Node.js project?',1),
(6,'Wisdom & Tips','How do you scale a Node.js server horizontally?',1),
(6,'Wisdom & Tips','What is the role of TypeScript in modern Node.js development?',0),
(6,'Wisdom & Tips','What trends are shaping the future of Node.js (Deno, Bun, etc.)?',1);

ALTER TABLE `questions` ENABLE KEYS;
UNLOCK TABLES;
-- Create layers table
CREATE TABLE IF NOT EXISTS layers (
    layer_id INT PRIMARY KEY AUTO_INCREMENT,
    code CHAR(2) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    color VARCHAR(7) NOT NULL
);

-- Create technologies table
CREATE TABLE IF NOT EXISTS technologies (
    tech_id INT PRIMARY KEY AUTO_INCREMENT,
    tech_name VARCHAR(100) NOT NULL,
    code CHAR(2) UNIQUE NOT NULL,
    default_layer_id INT NOT NULL,
    color VARCHAR(7) NOT NULL,
    ordinal INT NOT NULL,
    FOREIGN KEY (default_layer_id) REFERENCES layers(layer_id)
);

-- Insert 12 layers
INSERT INTO layers (code, name, color) VALUES
-- 1. Client
('Cl', 'Client', '#4285F4'), -- Browsers, Native Apps
-- 2. HTML
('Ht', 'HTML', '#E34C26'),
-- 3. CSS
('Cs', 'CSS', '#2965F1'),
-- 4. JavaScript
('Js', 'JavaScript', '#F7DF1E'),
-- 5. Operating System
('Os', 'Operating System', '#4CAF50'),
-- 6. Web/File Server
('Ws', 'Web/File Server', '#A9A9A9'),
-- 7. Programming Model
('Pm', 'Programming Model', '#6E4C1E'),
-- 8. Data Sources
('Db', 'Data Sources', '#4479A1'),
-- 9. Productivity & Admin
('Pa', 'Productivity & Admin', '#9C27B0'),
-- 10. Documentation
('Dc', 'Documentation', '#FF9800'),
-- 11. Testing
('Te', 'Testing', '#C21325'),
-- 12. Deployment & Maintenance
('Dm', 'Deployment & Maintenance', '#2ECC71');

-- Insert 5 technologies per layer (60 total)
INSERT INTO technologies (tech_name, code, default_layer_id, color, ordinal) VALUES
-- 1. Client
('Google Chrome', 'Gc', 1, '#4285F4', 1),
('Mozilla Firefox', 'Mf', 1, '#FF7139', 2),
('Safari', 'Sf', 1, '#1B9AF7', 3),
('Edge', 'Ed', 1, '#0078D7', 4),
('Android App', 'Aa', 1, '#3DDC84', 5),

-- 2. HTML
('HTML5', 'H5', 2, '#E34C26', 1),
('XHTML', 'Xh', 2, '#A86454', 2),
('Pug', 'Pg', 2, '#A86454', 3),
('HAML', 'Hm', 2, '#EFCF8B', 4),
('Slim', 'Sl', 2, '#E3C29B', 5),

-- 3. CSS
('CSS3', 'C3', 3, '#2965F1', 1),
('Sass', 'Sa', 3, '#CF649A', 2),
('LESS', 'Le', 3, '#1D365D', 3),
('Tailwind CSS', 'Tw', 3, '#38BDF8', 4),
('Bootstrap', 'Bs', 3, '#563D7C', 5),

-- 4. JavaScript
('Vanilla JS', 'Vj', 4, '#F7DF1E', 1),
('React', 'Re', 4, '#61DAFB', 2),
('Vue.js', 'Vu', 4, '#42B883', 3),
('Angular', 'Ng', 4, '#DD0031', 4),
('jQuery', 'Jq', 4, '#0769AD', 5),

-- 5. Operating System
('Ubuntu', 'Ub', 5, '#E95420', 1),
('CentOS', 'Ce', 5, '#262577', 2),
('Debian', 'Db', 5, '#A80030', 3),
('Windows Server', 'Ws', 5, '#00ADEF', 4),
('macOS', 'Mc', 5, '#999999', 5),

-- 6. Web/File Server
('Nginx', 'Ng', 6, '#009639', 1),
('Apache', 'Ap', 6, '#A9A9A9', 2),
('Caddy', 'Cd', 6, '#2D8CFF', 3),
('IIS', 'Ii', 6, '#0072C6', 4),
('Lighttpd', 'Lt', 6, '#D8D8D8', 5),

-- 7. Programming Model
('Node.js', 'Nd', 7, '#43853D', 1),
('Express', 'Ex', 7, '#000000', 2),
('Django', 'Dj', 7, '#092E20', 3),
('Laravel', 'Lv', 7, '#FF2D20', 4),
('Spring', 'Sp', 7, '#6DB33F', 5),

-- 8. Data Sources
('MySQL', 'My', 8, '#4479A1', 1),
('PostgreSQL', 'Pg', 8, '#336791', 2),
('MongoDB', 'Mg', 8, '#47A248', 3),
('SQLite', 'Sq', 8, '#003B57', 4),
('Redis', 'Rd', 8, '#DC382D', 5),

-- 9. Productivity & Admin
('VS Code', 'Vs', 9, '#007ACC', 1),
('Git', 'Gt', 9, '#F05032', 2),
('Docker Desktop', 'Dd', 9, '#2496ED', 3),
('GitHub', 'Gh', 9, '#24292E', 4),
('Jenkins', 'Jk', 9, '#D33833', 5),

-- 10. Documentation
('JSDoc', 'Js', 10, '#F7DF1E', 1),
('Swagger', 'Sw', 10, '#85EA2D', 2),
('Markdown', 'Md', 10, '#083FA1', 3),
('Sphinx', 'Sp', 10, '#000000', 4),
('Docusaurus', 'Ds', 10, '#3578E5', 5),

-- 11. Testing
('Jest', 'Je', 11, '#C21325', 1),
('Mocha', 'Mo', 11, '#8D6748', 2),
('Chai', 'Ch', 11, '#A30701', 3),
('Cypress', 'Cy', 11, '#17202C', 4),
('Pytest', 'Pt', 11, '#3776AB', 5),

-- 12. Deployment & Maintenance
('Docker', 'Dc', 12, '#2496ED', 1),
('Kubernetes', 'Kb', 12, '#326CE5', 2),
('Travis CI', 'Tc', 12, '#3EAAAF', 3),
('CircleCI', 'Cc', 12, '#343434', 4),
('Ansible', 'An', 12, '#EE0000', 5);

-- Add generic technologies for Python CGI, Perl CGI, PHP, .NET, ASP, MS SQL

-- Programming Model (layer 7)
INSERT INTO technologies (tech_name, code, default_layer_id, color, ordinal) VALUES
('Python CGI', 'Py', 7, '#3572A5', 6),
('Perl CGI', 'Pl', 7, '#0298C3', 7),
('PHP', 'Ph', 7, '#777BB4', 8),
('.NET', 'Dn', 7, '#512BD4', 9),
('ASP', 'As', 7, '#6D6D6D', 10);

-- Data Sources (layer 8)
INSERT INTO technologies (tech_name, code, default_layer_id, color, ordinal) VALUES
('MS SQL Server',