-- Example: For technology "React" (tech_id: 'react-uuid')
-- Create tables if not exist
CREATE TABLE IF NOT EXISTS technologies (
    tech_id VARCHAR(36) PRIMARY KEY,
    tech_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
    question_id VARCHAR(36) PRIMARY KEY,
    layer_id INT,
    question_category VARCHAR(50),
    question_text TEXT,
    is_required BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS technology_questions (
    tech_question_id VARCHAR(36) PRIMARY KEY,
    tech_id VARCHAR(36),
    question_id VARCHAR(36),
    FOREIGN KEY (tech_id) REFERENCES technologies(tech_id),
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

-- Insert React technology
INSERT INTO technologies (tech_id, tech_name) VALUES
('react-uuid', 'React');

-- Insert 10 general questions (layer_id = 2 for example)
INSERT INTO questions (question_id, layer_id, question_category, question_text, is_required) VALUES
('genq1', 2, 'General', 'What is this technology?', TRUE),
('genq2', 2, 'General', 'What is the primary use case?', TRUE),
('genq3', 2, 'General', 'How do you install it?', TRUE),
('genq4', 2, 'General', 'What are its main features?', TRUE),
('genq5', 2, 'General', 'How do you update it?', TRUE),
('genq6', 2, 'General', 'What are common pitfalls?', TRUE),
('genq7', 2, 'General', 'How is it licensed?', TRUE),
('genq8', 2, 'General', 'What is the latest stable version?', TRUE),
('genq9', 2, 'General', 'Where is the official documentation?', TRUE),
('genq10', 2, 'General', 'What are popular alternatives?', TRUE);

-- Insert 30 React-specific questions
INSERT INTO questions (question_id, layer_id, question_category, question_text, is_required) VALUES
('reactq1', 2, 'Tech-Specific', 'How does React handle state management?', TRUE),
('reactq2', 2, 'Tech-Specific', 'What is JSX?', TRUE),
('reactq3', 2, 'Tech-Specific', 'How do you create a component?', TRUE),
('reactq4', 2, 'Tech-Specific', 'What are hooks in React?', TRUE),
('reactq5', 2, 'Tech-Specific', 'How do you manage side effects?', TRUE),
('reactq6', 2, 'Tech-Specific', 'How does React handle events?', TRUE),
('reactq7', 2, 'Tech-Specific', 'How do you optimize performance?', TRUE),
('reactq8', 2, 'Tech-Specific', 'How do you handle forms?', TRUE),
('reactq9', 2, 'Tech-Specific', 'What is the virtual DOM?', TRUE),
('reactq10', 2, 'Tech-Specific', 'How do you do routing in React?', TRUE),
('reactq11', 2, 'Tech-Specific', 'How do you fetch data from APIs?', TRUE),
('reactq12', 2, 'Tech-Specific', 'How do you use context?', TRUE),
('reactq13', 2, 'Tech-Specific', 'How do you test React components?', TRUE),
('reactq14', 2, 'Tech-Specific', 'How do you handle errors?', TRUE),
('reactq15', 2, 'Tech-Specific', 'How do you use refs?', TRUE),
('reactq16', 2, 'Tech-Specific', 'How do you do server-side rendering?', TRUE),
('reactq17', 2, 'Tech-Specific', 'How do you use React with TypeScript?', TRUE),
('reactq18', 2, 'Tech-Specific', 'How do you deploy a React app?', TRUE),
('reactq19', 2, 'Tech-Specific', 'How do you use Redux with React?', TRUE),
('reactq20', 2, 'Tech-Specific', 'How do you lazy load components?', TRUE),
('reactq21', 2, 'Tech-Specific', 'How do you handle authentication?', TRUE),
('reactq22', 2, 'Tech-Specific', 'How do you use React with CSS frameworks?', TRUE),
('reactq23', 2, 'Tech-Specific', 'How do you use portals?', TRUE),
('reactq24', 2, 'Tech-Specific', 'How do you memoize components?', TRUE),
('reactq25', 2, 'Tech-Specific', 'How do you use PropTypes?', TRUE),
('reactq26', 2, 'Tech-Specific', 'How do you handle accessibility?', TRUE),
('reactq27', 2, 'Tech-Specific', 'How do you use Suspense?', TRUE),
('reactq28', 2, 'Tech-Specific', 'How do you use Error Boundaries?', TRUE),
('reactq29', 2, 'Tech-Specific', 'How do you use custom hooks?', TRUE),
('reactq30', 2, 'Tech-Specific', 'How do you optimize bundle size?', TRUE);

-- Link React-specific questions to React technology
INSERT INTO technology_questions (tech_question_id, tech_id, question_id) VALUES
('tq1', 'react-uuid', 'reactq1'),
('tq2', 'react-uuid', 'reactq2'),
('tq3', 'react-uuid', 'reactq3'),
('tq4', 'react-uuid', 'reactq4'),
('tq5', 'react-uuid', 'reactq5'),
('tq6', 'react-uuid', 'reactq6'),
('tq7', 'react-uuid', 'reactq7'),
('tq8', 'react-uuid', 'reactq8'),
('tq9', 'react-uuid', 'reactq9'),
('tq10', 'react-uuid', 'reactq10'),
('tq11', 'react-uuid', 'reactq11'),
('tq12', 'react-uuid', 'reactq12'),
('tq13', 'react-uuid', 'reactq13'),
('tq14', 'react-uuid', 'reactq14'),
('tq15', 'react-uuid', 'reactq15'),
('tq16', 'react-uuid', 'reactq16'),
('tq17', 'react-uuid', 'reactq17'),
('tq18', 'react-uuid', 'reactq18'),
('tq19', 'react-uuid', 'reactq19'),
('tq20', 'react-uuid', 'reactq20'),
('tq21', 'react-uuid', 'reactq21'),
('tq22', 'react-uuid', 'reactq22'),
('tq23', 'react-uuid', 'reactq23'),
('tq24', 'react-uuid', 'reactq24'),
('tq25', 'react-uuid', 'reactq25'),
('tq26', 'react-uuid', 'reactq26'),
('tq27', 'react-uuid', 'reactq27'),
('tq28', 'react-uuid', 'reactq28'),
('tq29', 'react-uuid', 'reactq29'),
('tq30',