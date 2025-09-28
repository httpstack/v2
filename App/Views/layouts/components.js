// --- Helper to define components quickly ---

const Icons = {
    Layers: `<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 2 7 12 12 22 7 12 2"></polygon><polyline points="2 17 12 22 22 17"></polyline><polyline points="2 12 12 17 22 12"></polyline></svg>`,
    Target: `<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><circle cx="12" cy="12" r="6"></circle><circle cx="12" cy="12" r="2"></circle></svg>`,
    FileText: `<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><line x1="10" y1="9" x2="8" y2="9"></line></svg>`,
    Database: `<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><ellipse cx="12" cy="5" rx="9" ry="3"></ellipse><path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"></path><path d="M3 12c0 1.66 4 3 9 3s9-1.34 9-3"></path></svg>`,
    Zap: `<svg xmlns="http://www.w3.org/2000/svg" class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>`,
};
function createComponent(tag, template) {
    customElements.define(tag, class extends HTMLElement {
        constructor() {
            super();
            const shadow = this.attachShadow({ mode: 'open' });
            shadow.innerHTML = template;
        }
    });
}

// --- UI Elements ---
// Button
createComponent("ui-button", `
  <style>
    :host { display:inline-block; }
    button {
      background: var(--primary);
      color: white;
      border: none;
      border-radius: 0.5rem;
      padding: 0.5rem 1rem;
      cursor: pointer;
      font: inherit;
    }
    button:hover { background: var(--primary-hover); }
  </style>
  <button><slot></slot></button>
`);

// Card
createComponent("ui-card", `
  <style>
    :host { display:block; }
    .card {
      border: 1px solid var(--card-border);
      border-radius: 0.75rem;
      padding: 1rem;
      background: var(--card-bg);
      box-shadow: 0 2px 6px rgba(0,0,0,0.1);
    }
  </style>
  <div class="card"><slot></slot></div>
`);

// Badge
createComponent("ui-badge", `
  <style>
    :host { display:inline-block; }
    .badge {
      background: var(--primary);
      color: white;
      padding: 0.25rem 0.5rem;
      border-radius: 0.375rem;
      font-size: 0.75rem;
      margin: 0 0.125rem;
    }
  </style>
  <span class="badge"><slot></slot></span>
`);

// --- Home Page Component ---
customElements.define("home-page", class extends HTMLElement {
    constructor() {
        super();
        this.attachShadow({ mode: "open" });
    }

    connectedCallback() {
        this.render();
    }

    render() {
        this.shadowRoot.innerHTML = `
      <style>
        .hero { text-align:center; padding:2rem 1rem; }
        .features { display:grid; grid-template-columns:repeat(auto-fit,minmax(250px,1fr)); gap:1rem; margin-top:2rem; }
        .stacks { margin-top:2rem; }
        .stack { margin:1rem 0; }
        .compat { font-size:0.9rem; color:var(--muted); }
        .layers { display:flex; gap:0.25rem; margin-top:0.5rem; }
        .layer { padding:0.25rem 0.5rem; border-radius:0.25rem; background:var(--card-border); }
        .arch { margin-top:2rem; display:grid; gap:1rem; }
        .arch-item { padding:0.75rem; border-left:6px solid var(--primary); background:var(--card-bg); }
        form { margin-top:2rem; display:flex; gap:0.5rem; justify-content:center; }
        input { padding:0.5rem; border:1px solid var(--card-border); border-radius:0.5rem; flex:1; }
        .success { color: var(--success); margin-top:0.5rem; text-align:center; }
      </style>
      <section class="container hero">
        <h1>Build Amazing Stacks</h1>
        <p>Generate, customize, and document your full-stack setups.</p>
        <ui-button id="startBtn">Get Started</ui-button>
      </section>
<section class="container features">
  <ui-card class="feature">
    <h3>${Icons.Layers} Stack Builder</h3>
    <p>Create custom tech stacks by combining layers from Client to Deployment.</p>
  </ui-card>
  <ui-card class="feature">
    <h3>${Icons.Target} Compatibility Engine</h3>
    <p>AI-powered analysis scores your stack and flags potential issues.</p>
  </ui-card>
  <ui-card class="feature">
    <h3>${Icons.FileText} Documentation Generator</h3>
    <p>Generate step-by-step guides tailored to your specific stack.</p>
  </ui-card>
</section>

      <section class="container stacks">
        <h2>Popular Stacks</h2>
        <div id="stackList"></div>
      </section>

      <section class="container arch">
        <h2>Architecture Layers</h2>
        <div id="archList"></div>
      </section>

      <section class="container">
        <h2>Stay Updated</h2>
        <form id="subscribeForm">
          <input type="email" id="emailInput" placeholder="Enter your email" required />
          <ui-button type="submit">Subscribe</ui-button>
        </form>
        <div id="formMessage" class="success"></div>
      </section>
    `;

        this.renderStacks();
        this.renderArchitecture();
        this.addFormHandler();
    }

    renderStacks() {
        const stacks = [
            { name: 'LAMP', layers: ['L', 'A', 'M', 'P'], compatibility: 95 },
            { name: 'MERN', layers: ['M', 'E', 'R', 'N'], compatibility: 98 },
            { name: 'VUE + Laravel', layers: ['V', 'L', 'A', 'M'], compatibility: 92 },
            { name: 'Next + Django', layers: ['N', 'D', 'P', 'S'], compatibility: 88 }
        ];
        const container = this.shadowRoot.querySelector("#stackList");
        container.innerHTML = stacks.map(s => `
      <ui-card class="stack">
        <h3>${s.name}</h3>
        <div class="layers">${s.layers.map(l => `<ui-badge>${l}</ui-badge>`).join('')}</div>
        <p class="compat">Compatibility: ${s.compatibility}%</p>
      </ui-card>
    `).join('');
    }

    renderArchitecture() {
        const layers = [
            { id: 'C', name: 'Client', description: 'User Interface' },
            { id: 'H', name: 'HTML', description: 'Markup Layer' },
            { id: 'S', name: 'Server', description: 'Business Logic' },
            { id: 'D', name: 'Database', description: 'Persistent Storage' },
            { id: 'P', name: 'Platform', description: 'Deployment' }
        ];
        const container = this.shadowRoot.querySelector("#archList");
        container.innerHTML = layers.map(l => `
      <div class="arch-item">
        <strong>${l.name}</strong> - ${l.description}
      </div>
    `).join('');
    }

    addFormHandler() {
        const form = this.shadowRoot.querySelector("#subscribeForm");
        const input = this.shadowRoot.querySelector("#emailInput");
        const message = this.shadowRoot.querySelector("#formMessage");
        form.addEventListener("submit", e => {
            e.preventDefault();
            message.textContent = `✅ Thanks, ${input.value}! You are subscribed.`;
            input.value = "";
        });
    }
});
