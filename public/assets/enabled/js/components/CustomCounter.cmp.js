class CustomCounter extends HTMLElement {
    constructor() {
        super(); // Always call super first
        this._count = 0; // Internal state property

        // Attach a Shadow DOM for encapsulated styles and markup
        this.attachShadow({ mode: 'open' });
    }
    // ... constructor, attribute callbacks, render ...
    static get observedAttributes() {
        // List which attributes to "watch" for changes
        return ['start'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        // Fired when an observed attribute changes
        if (name === 'start') {
            this._count = Number(newValue) || 0;
            this.render(); // Re-render when the attribute changes
        }
    }
    connectedCallback() {
        // Fired when the element is added to the page
        this.render(); // Perform the initial render

        // Add event listeners
        this.shadowRoot.getElementById('increment-btn').addEventListener('click', () => {
            this._count++;
            this.render(); // Manually re-render after state changes
        });
    }

    disconnectedCallback() {
        // Fired when the element is removed from the page.
        // Clean up event listeners here if necessary.
    }

    render() {
        this.shadowRoot.innerHTML = `
      <style>
        /* Styles are scoped to this component! */
        p {
          font-family: sans-serif;
        }
        button {
          padding: 8px 12px;
          border-radius: 4px;
          border: 1px solid #ccc;
          cursor: pointer;
        }
      </style>
      <div>
        <p>Count: ${this._count}</p>
        <button id="increment-btn">Increment</button>
      </div>
    `;
    }
}

window.customElements.define('custom-counter', CustomCounter);