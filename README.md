# 🌲 file-tree-generator

```bash
sudo ./file-tree.sh sample.txt
```

The simplest way to generate file and folder structure from a tree drawn with ASCII symbols.

Tags: project scaffolding, tree, file, folder, structure, generator, ASCII, symbols, bash, shell, script

It creates a directory and file structure based on the input format you provided in a **tree.txt**.

Example of a **tree.txt**:

```text
some-app/
|-- public/
|   |-- index.html
|-- src/
|   |-- components/
|   |   |-- App.vue
|   |   |-- List.vue
|   |   |-- SubmissionForm.vue
|   |   |-- SuccessMessage.vue
|   |-- main.js
|   |-- sendEmail.js
|-- README.md
|-- vue.config.js
```

# Using a script with a custom file

You can call the script wit a parameter to set your custom file as an input source.

```bash
sudo ./file-tree.sh <input-file>
```

# 