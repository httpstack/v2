// api-config.js
const API_BASE = 'https://api.httpstack.tech/v1';

const HttpStackAPI = {
    // Layer endpoints
    layers: {
        getAll: () => `${API_BASE}/layers`,
        getById: (id) => `${API_BASE}/layers/${id}`,
        getTechnologies: (layerId) => `${API_BASE}/layers/${layerId}/technologies`,
        getQuestions: (layerId) => `${API_BASE}/layers/${layerId}/questions`
    },

    // Stack endpoints
    stacks: {
        getAll: () => `${API_BASE}/stacks`,
        getById: (id) => `${API_BASE}/stacks/${id}`,
        create: () => `${API_BASE}/stacks`,
        update: (id) => `${API_BASE}/stacks/${id}`,
        validate: (id) => `${API_BASE}/stacks/${id}/validate`
    },

    // Technology endpoints
    technologies: {
        getAll: () => `${API_BASE}/technologies`,
        search: (query) => `${API_BASE}/technologies?search=${encodeURIComponent(query)}`,
        getCompatibility: (techIds) => `${API_BASE}/technologies/compatibility?ids=${techIds.join(',')}`
    },

    // Documentation endpoints
    documentation: {
        generate: (stackId) => `${API_BASE}/stacks/${stackId}/documentation`,
        export: (stackId, format) => `${API_BASE}/stacks/${stackId}/export?format=${format}`
    }
};
// httpstack-ajax.js
class HttpStackAJAX {
    constructor() {
        this.cache = new Map();
        this.pendingRequests = new Map();
    }

    // Generic request handler with caching
    async request(endpoint, options = {}) {
        const cacheKey = `${endpoint}-${JSON.stringify(options)}`;

        // Return cached result if available
        if (this.cache.has(cacheKey) && !options.forceRefresh) {
            return this.cache.get(cacheKey);
        }

        // Prevent duplicate requests
        if (this.pendingRequests.has(cacheKey)) {
            return this.pendingRequests.get(cacheKey);
        }

        const requestPromise = this._makeRequest(endpoint, options)
            .then(data => {
                this.cache.set(cacheKey, data);
                this.pendingRequests.delete(cacheKey);
                return data;
            })
            .catch(error => {
                this.pendingRequests.delete(cacheKey);
                throw error;
            });

        this.pendingRequests.set(cacheKey, requestPromise);
        return requestPromise;
    }

    async _makeRequest(endpoint, options) {
        const response = await fetch(endpoint, {
            method: options.method || 'GET',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest',
                ...options.headers
            },
            body: options.body ? JSON.stringify(options.body) : undefined
        });

        if (!response.ok) {
            throw new Error(`API Error: ${response.status} ${response.statusText}`);
        }

        return response.json();
    }

    // Layer-specific methods
    async getLayers() {
        return this.request(HttpStackAPI.layers.getAll());
    }

    async getLayerDetails(layerId) {
        return this.request(HttpStackAPI.layers.getById(layerId));
    }

    async getLayerTechnologies(layerId) {
        return this.request(HttpStackAPI.layers.getTechnologies(layerId));
    }

    async getLayerQuestions(layerId) {
        return this.request(HttpStackAPI.layers.getQuestions(layerId));
    }

    // Stack-specific methods
    async createStack(stackData) {
        return this.request(HttpStackAPI.stacks.create(), {
            method: 'POST',
            body: stackData
        });
    }

    async updateStack(stackId, updates) {
        return this.request(HttpStackAPI.stacks.update(stackId), {
            method: 'PATCH',
            body: updates
        });
    }

    async validateStack(stackId) {
        return this.request(HttpStackAPI.stacks.validate(stackId));
    }

    // Technology compatibility
    async checkCompatibility(techIds) {
        return this.request(HttpStackAPI.technologies.getCompatibility(techIds));
    }

    // Documentation generation
    async generateDocumentation(stackId) {
        return this.request(HttpStackAPI.documentation.generate(stackId), {
            method: 'POST'
        });
    }

    // Clear cache for specific endpoints
    clearCache(pattern) {
        for (const key of this.cache.keys()) {
            if (key.includes(pattern)) {
                this.cache.delete(key);
            }
        }
    }
}