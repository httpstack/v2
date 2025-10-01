// Layer Objects
const layers = [
    { code: "Cl", name: "Client", color: "#4285F4", description: "User-facing component." },
    { code: "Ht", name: "HTML", color: "#E34C26", description: "Structural skeleton." },
    { code: "Cs", name: "CSS", color: "#2965F1", description: "Style & presentation." },
    { code: "Js", name: "JavaScript", color: "#F7DF1E", description: "Dynamic interactivity." },
    { code: "Os", name: "Operating System", color: "#4CAF50", description: "OS foundation." },
    { code: "Ws", name: "Web/File Server", color: "#A9A9A9", description: "Handles incoming requests." },
    { code: "Pm", name: "Programming Model", color: "#6E4C1E", description: "Server-side logic & frameworks." },
    { code: "Db", name: "Data Sources", color: "#4479A1", description: "Databases & persistence." },
    { code: "Pa", name: "Productivity & Admin", color: "#9C27B0", description: "Developer tools." },
    { code: "Dc", name: "Documentation", color: "#FF9800", description: "Documentation tools." },
    { code: "Te", name: "Testing", color: "#C21325", description: "Testing & QA tools." },
    { code: "Dm", name: "Deployment & Maintenance", color: "#2ECC71", description: "CI/CD & infra." },
];

// Populate Periodic Table
const grid = document.getElementById("elementsGrid");
layers.forEach((layer, index) => {
    const card = document.createElement("div");
    card.classList.add("element-card");
    card.style.backgroundColor = layer.color;
    card.innerHTML = `
    <div class="element-code">${layer.code}</div>
    <div class="element-name">${layer.name}</div>
    <div class="element-id">${index + 1}</div>
  `;
    grid.appendChild(card);
});

// Populate Layers List
const layersList = document.getElementById("layersList");
layers.forEach((layer) => {
    const card = document.createElement("div");
    card.classList.add("layer-card");
    card.style.backgroundColor = layer.color;
    card.innerHTML = `
    <h3>${layer.code} – ${layer.name}</h3>
    <p>${layer.description}</p>
  `;
    layersList.appendChild(card);
});

// Example Hash (for demo purposes)
document.getElementById("hashExample").textContent =
    md5("Ht1 Cs3 Js4 Db8").slice(0, 8);

// Theme Toggle
const themeToggle = document.getElementById("themeToggle");
themeToggle.addEventListener("click", () => {
    const html = document.documentElement;
    if (html.getAttribute("data-theme") === "light") {
        html.setAttribute("data-theme", "dark");
    } else {
        html.setAttribute("data-theme", "light");
    }
});

// Hamburger Menu
const hamburger = document.getElementById("hamburger");
const mainNav = document.getElementById("mainNav");
hamburger.addEventListener("click", () => {
    mainNav.classList.toggle("nav-open");
});


// Simple MD5 implementation
function md5(str) {
    return CryptoJS.MD5(str).toString();
}

// Load CryptoJS for hashing
const script = document.createElement("script");
script.src = "https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.2.0/crypto-js.min.js";
document.body.appendChild(script);
