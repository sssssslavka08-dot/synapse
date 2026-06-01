// ═══════════════════════════════════════════════════════════════
//  SYNAPSE Admin Panel — shared JS
// ═══════════════════════════════════════════════════════════════

const SUPABASE_URL  = 'https://sgtihvgzginbvsdqhqfi.supabase.co';
const SUPABASE_KEY  = 'REDACTED';

// Init Supabase client (loaded from CDN)
const { createClient } = window.supabase;
const db = createClient(SUPABASE_URL, SUPABASE_KEY);

// ── Sidebar toggle (mobile) ──────────────────────────────────
function initSidebar() {
  const btn = document.getElementById('menuBtn');
  const sidebar = document.querySelector('.sidebar');
  if (btn && sidebar) {
    btn.addEventListener('click', () => sidebar.classList.toggle('open'));
    document.addEventListener('click', e => {
      if (!sidebar.contains(e.target) && e.target !== btn) {
        sidebar.classList.remove('open');
      }
    });
  }
}

// ── Utility: format date ────────────────────────────────────
function fmtDate(iso) {
  if (!iso) return '—';
  const d = new Date(iso);
  return d.toLocaleDateString('ru-RU', { day:'2-digit', month:'short', year:'numeric' });
}

// ── Utility: plan badge ─────────────────────────────────────
function planBadge(plan) {
  const m = { free:'badge-free', pro:'badge-pro', legenda:'badge-legenda' };
  const labels = { free:'🌱 FREE', pro:'⚡ PRO', legenda:'👑 LEGENDA' };
  return `<span class="badge ${m[plan]||'badge-free'}">${labels[plan]||plan}</span>`;
}

// ── Utility: age group badge ────────────────────────────────
function ageBadge(age) {
  return age > 0 && age <= 12
    ? '<span class="badge badge-kids">👶 Дети</span>'
    : '<span class="badge badge-adult">👤 Взрослый</span>';
}

// ── Toast notification ──────────────────────────────────────
function toast(msg, type = 'success') {
  let el = document.getElementById('toast');
  if (!el) {
    el = document.createElement('div');
    el.id = 'toast';
    Object.assign(el.style, {
      position:'fixed', bottom:'24px', right:'24px',
      padding:'12px 20px', borderRadius:'12px',
      fontWeight:'600', fontSize:'14px',
      zIndex:'999', transition:'opacity .3s',
      opacity:'0'
    });
    document.body.appendChild(el);
  }
  el.textContent = msg;
  el.style.background = type === 'success' ? '#22c55e' : '#ef4444';
  el.style.color = '#fff';
  el.style.opacity = '1';
  setTimeout(() => el.style.opacity = '0', 2800);
}

// ── Modal helpers ────────────────────────────────────────────
function openModal(id) {
  document.getElementById(id)?.classList.add('open');
}
function closeModal(id) {
  document.getElementById(id)?.classList.remove('open');
}
function closeOnOverlay(id) {
  const el = document.getElementById(id);
  el?.addEventListener('click', e => {
    if (e.target === el) closeModal(id);
  });
}

// DOM ready
document.addEventListener('DOMContentLoaded', initSidebar);
