import '@fortawesome/fontawesome-free';
import 'bulma/css/bulma.css'
import './app.css'
import * as monaco from 'monaco-editor';
import 'monaco-editor/dev/vs/editor/editor.main.css'
import 'monaco-editor/esm/vs/editor/standalone/common/themes.js'

declare var Elm: any;

(self as any)['MonacoEnvironment'] = {
    getWorkerUrl: function (moduleId: any, label: string) {
        if (label === 'json') {
            return './json.worker.bundle.js';
        }
        if (label === 'css') {
            return './css.worker.bundle.js';
        }
        if (label === 'html') {
            return './html.worker.bundle.js';
        }
        return './editor.worker.bundle.js';
    }
}

class MonacoEditorElement extends HTMLElement {
    _editor: monaco.editor.IStandaloneCodeEditor
    _editorValue: string
    _editorLanguage: string
    _editorReadOnly: boolean

    get editorValue() {
        return this._editorValue || "";
    }

    set editorValue(v: string) {
        this._editorValue = v;
    }

    get language() {
        return this._editorLanguage || 'html';
    }

    set language(l: string) {
        this._editorLanguage = l;
    }

    get readOnly() {
        return this._editorReadOnly || false;
    }

    set readOnly(r: boolean) {
        this._editorReadOnly = r;
    }

    connectedCallback() {
        this._editor = monaco.editor.create(this, {
            value: this.editorValue,
            language: this.language,
            readOnly: this.readOnly,
            fontLigatures: true,
            fontSize: 14,
            renderLineHighlight: "none",
            theme: 'vs-dark',
            minimap: { enabled: false },
            matchBrackets: false,
        });
        this._editor.onDidChangeModelContent(e => {
            this.editorValue = this._editor.getValue();
            this.dispatchEvent(new CustomEvent("editorChanged"));
        });
    }
}

customElements.define('code-editor', MonacoEditorElement);

Elm.Main.init({
    node: document.getElementById("elm-app"),
    flags: ""
});