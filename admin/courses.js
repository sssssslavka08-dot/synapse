// Редактор глав курсов (localStorage) — без пересборки Flutter
const LANGS = [
  { code: 'en', name: 'Английский', emoji: '🇬🇧' },
  { code: 'ru', name: 'Русский', emoji: '🇷🇺' },
  { code: 'kz', name: 'Казахский', emoji: '🇰🇿' },
  { code: 'de', name: 'Немецкий', emoji: '🇩🇪' },
  { code: 'fr', name: 'Французский', emoji: '🇫🇷' },
  { code: 'es', name: 'Испанский', emoji: '🇪🇸' },
  { code: 'it', name: 'Итальянский', emoji: '🇮🇹' },
  { code: 'tr', name: 'Турецкий', emoji: '🇹🇷' },
  { code: 'zh', name: 'Китайский', emoji: '🇨🇳' },
  { code: 'ja', name: 'Японский', emoji: '🇯🇵' },
  { code: 'ko', name: 'Корейский', emoji: '🇰🇷' },
  { code: 'ar', name: 'Арабский', emoji: '🇸🇦' },
];

const STORAGE_KEY = (lang) => `synapse_course_edit_${lang}`;

let currentLang = 'en';
let currentChapterId = null;

function defaultChapter(lang, index) {
  return {
    id: `${lang}_edit_${index}`,
    title: `Новая глава ${index}`,
    subtitle: 'Подзаголовок',
    emoji: '📖',
    level: 1,
    chapterNumber: index,
    theory: [{ title: 'Теория', content: 'Текст теории…', examples: ['Пример 1'] }],
    exercises: [],
    exam: [],
    xpReward: 30,
    coinsReward: 20,
  };
}

function loadChapters(lang) {
  const raw = localStorage.getItem(STORAGE_KEY(lang));
  if (raw) {
    try {
      return JSON.parse(raw);
    } catch (_) {}
  }
  return [defaultChapter(lang, 1)];
}

function saveChapters(lang, chapters) {
  localStorage.setItem(STORAGE_KEY(lang), JSON.stringify(chapters, null, 2));
}

function renderLangSelect() {
  const sel = document.getElementById('langSelect');
  sel.innerHTML = LANGS.map(
    (l) => `<option value="${l.code}">${l.emoji} ${l.name}</option>`
  ).join('');
  sel.value = currentLang;
  sel.onchange = () => {
    currentLang = sel.value;
    currentChapterId = null;
    renderChapterList();
    loadEditor();
  };
}

function renderChapterList() {
  const chapters = loadChapters(currentLang);
  const list = document.getElementById('chapterList');
  if (!currentChapterId && chapters.length) {
    currentChapterId = chapters[0].id;
  }
  list.innerHTML = chapters
    .map(
      (ch) => `
    <div class="chapter-item ${ch.id === currentChapterId ? 'active' : ''}" data-id="${ch.id}">
      ${ch.emoji || '📖'} ${ch.title}
    </div>`
    )
    .join('');
  list.querySelectorAll('.chapter-item').forEach((el) => {
    el.onclick = () => {
      persistEditor();
      currentChapterId = el.dataset.id;
      renderChapterList();
      loadEditor();
    };
  });
}

function getCurrentChapter() {
  const chapters = loadChapters(currentLang);
  return chapters.find((c) => c.id === currentChapterId) || chapters[0];
}

function loadEditor() {
  const ch = getCurrentChapter();
  if (!ch) return;
  currentChapterId = ch.id;
  document.getElementById('chapterEditor').value = JSON.stringify(ch, null, 2);
}

function persistEditor() {
  const ta = document.getElementById('chapterEditor');
  try {
    const parsed = JSON.parse(ta.value);
    const chapters = loadChapters(currentLang);
    const idx = chapters.findIndex((c) => c.id === currentChapterId);
    if (idx >= 0) chapters[idx] = parsed;
    else chapters.push(parsed);
    currentChapterId = parsed.id;
    saveChapters(currentLang, chapters);
    return true;
  } catch (e) {
    toast('Ошибка JSON: ' + e.message, 'error');
    return false;
  }
}

document.getElementById('btnSave').onclick = () => {
  if (persistEditor()) {
    toast('Глава сохранена');
    renderChapterList();
  }
};

document.getElementById('btnAddChapter').onclick = () => {
  persistEditor();
  const chapters = loadChapters(currentLang);
  const ch = defaultChapter(currentLang, chapters.length + 1);
  chapters.push(ch);
  saveChapters(currentLang, chapters);
  currentChapterId = ch.id;
  renderChapterList();
  loadEditor();
  toast('Добавлена глава');
};

document.getElementById('btnExport').onclick = () => {
  if (!persistEditor()) return;
  const data = loadChapters(currentLang);
  const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = `synapse_course_${currentLang}.json`;
  a.click();
  toast('JSON скачан');
};

document.getElementById('btnImport').onclick = () => document.getElementById('fileImport').click();
document.getElementById('fileImport').onchange = (e) => {
  const file = e.target.files[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = () => {
    try {
      const data = JSON.parse(reader.result);
      if (!Array.isArray(data)) throw new Error('Нужен массив глав');
      saveChapters(currentLang, data);
      currentChapterId = data[0]?.id;
      renderChapterList();
      loadEditor();
      toast('Импортировано');
    } catch (err) {
      toast(err.message, 'error');
    }
  };
  reader.readAsText(file);
};

initSidebar();
renderLangSelect();
renderChapterList();
loadEditor();
