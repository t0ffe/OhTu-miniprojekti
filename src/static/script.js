function add_author(name = '') {
    var authorsContainer = document.getElementById('authorsContainer');
    var Authors = authorsContainer.getElementsByClassName('author-entry').length;

    if (Authors >= 21) {
      alert('You can only add max 21 authors');
      return;
    }

    const authorEntry = document.createElement('div');
    authorEntry.className = 'author-entry';
    authorEntry.innerHTML = `
        <input placeholder="Author*" type="text" name="author" minlength="1" maxlength="200" value="${name}" required>
        <button class="add-author-button" type="button" onclick="add_author()">+</button>
        <button type="button" class="remove-author" onclick="remove_author(this)">×</button>`;
    authorsContainer.appendChild(authorEntry);
  }

  function remove_author(button) {
    var authorsContainer = document.getElementById('authorsContainer');
    button.parentElement.remove();
    if (authorsContainer.getElementsByClassName('author-entry').length === 0) {
      add_author();
    }
  }
  function select_reference_type(type) {
    document.getElementById('reference-type').value = type;
  }

  const form_fields = {
    article:       { required: ["author", "title", "journal", "year"], 
                     optional: ["volume", "number", "pages", "month", "note"] },
    book:          { required: ["author", "editor", "title", "publisher", "year"],
                     optional: ["volume", "number", "pages", "month", "note"] },
    booklet:       { required: ["author", "title", "howpublished", "address", "year"],
                     optional: ["editor", "volume", "number", "organization", "month", "note"] },
    conference:    { required: ["author", "title", "booktitle", "year"],
                     optional: ["editor", "volume", "number", "pages", "address", "month", "organization", "publisher", "note"] },
    inbook:        { required: ["author", "title", "booktitle", "publisher", "year"],
                     optional: ["editor", "volume", "number", "address", "edition", "month", "pages", "note"] },
    incollection:  { required: ["author", "title", "booktitle", "publisher", "year"],
                     optional: ["editor", "volume", "number", "pages", "address", "month"] },
    inproceedings: { required: ["author", "title", "booktitle", "year"],
                     optional: ["editor", "volume", "number", "pages", "address", "month", "organization", "publisher"] },
    manual:        { required: ["title", "year"],
                     optional: ["author", "organization", "address", "edition", "month", "note"] },
    mastersthesis: { required: ["author", "title", "school", "year"],
                     optional: ["type", "address", "month", "note"] },
    misc:          { required: [],
                     optional: ["author", "title", "howpublished", "month", "year", "note"] },
    phdthesis:     { required: ["author", "title", "school", "year"],
                     optional: ["type", "address", "month", "note"] },
    proceedings:   { required: ["title", "year"],
                     optional: ["editor", "volume", "number", "series", "address", "month", "publisher"] },
    techreport:    { required: ["author", "title", "institution", "year"],
                     optional: ["type", "number", "address", "month", "note"] },
    unpublished:   { required: ["author", "title", "note"],
                     optional: ["month", "year"] },
  };

  const update_form = () => {
    const type = document.getElementById("reference-type").value;
    const fields = form_fields[type];
    const formFieldsDiv = document.getElementById("fields");
    formFieldsDiv.innerHTML = "";
    const hasAuthors = fields.required.includes("author") || (type === "manual" || type === "misc");

    if (hasAuthors) {
      append_authors_container(formFieldsDiv, type === "manual" || type === "misc");
    }

    append_fields(formFieldsDiv, fields.required, true);
    append_fields(formFieldsDiv, fields.optional, false);

    if (typeof referenceData !== 'undefined') {
      fields.required.concat(fields.optional).forEach(field => {
        const fieldElement = document.getElementById(field);
        if (fieldElement && referenceData[field]) {
          fieldElement.value = referenceData[field];
        }
      });
      if (authorsData) {
        const authorsContainer = document.getElementById('authorsContainer');
        authorsContainer.innerHTML = ''; // this will remove the default author field
        authorsData.split(',').forEach(author => {
          author = author.trim();
          add_author(author);
        });
      }
    }
  };

  const append_authors_container = (container, optional = false) => {
    const authorsContainer = document.createElement("div");
    authorsContainer.className = "authors-container";
    authorsContainer.innerHTML = `<div id="authorsContainer"></div>`;
    container.appendChild(authorsContainer);
    add_author('');
  };

  const append_fields = (container, fields, required) => {
    const div = document.createElement("div");
    for (const field of fields) {
      if (field !== "author") {
        div.appendChild(create_field(field, required));
      }
    }
    container.appendChild(div);
  };

  const create_field = (field, required) => {
    const row = document.createElement("div");
    row.className = "field_contents"

    const input = document.createElement("input");
    input.placeholder = field.charAt(0).toUpperCase() + field.slice(1) + (required ? " *" : " (Optional)");
    input.name = field;
    input.required = required;

    switch (field) {
      case "title":
      case "journal":
      case "pages":
      case "note":
        input.type = "text";
        input.minLength = 1;
        input.maxLength = 200;
        break;
      case "year":
        input.type = "number";
        input.min = 1;
        input.max = 2100;
        break;
      case "volume":
      case "number":
        input.type = "number";
        input.min = 1;
        input.max = 5000;
        break;
      case "month":
        input.type = "number";
        input.min = 1;
        input.max = 12;
        break;
      default:
        input.type = "text";
    }
    input.id = field;

    row.appendChild(input);
    return row;
  };
  
async function search_DOI() {
  const doiInput = document.getElementById('doiSearch');
  const statusDiv = document.getElementById('doiSearchStatus');
  const doi = doiInput.value.trim();

  if (!doi) {
      show_DOI_status('Please enter a DOI', 'error');
      return;
  }

  show_DOI_status('Searching...', 'loading');

  try {
      const response = await fetch(`https://api.crossref.org/works/${encodeURIComponent(doi)}`);
      const data = await response.json();

      if (data.status !== 'ok') {
          throw new Error('Failed to fetch DOI data');
      }
    
      const work = data.message;
      populate_form_with_DOI_data(work);
      show_DOI_status('Reference data found and form populated!', 'success');
  } catch (error) {
      show_DOI_status('Could not find reference data for this DOI. Please check the DOI and try again.', 'error');
      console.error('DOI lookup error:', error);
  }
}

function show_DOI_status(message, type) {
  const statusDiv = document.getElementById('doiSearchStatus');
  statusDiv.textContent = message;
  statusDiv.className = 'search-status';
  statusDiv.classList.add(type);
}

function populate_form_with_DOI_data(work) {
  let type = 'article';
  switch (work.type) {
      case 'book':
      case 'edited-book':
      case 'reference-book':
      case 'monograph':
          type = 'book';
          break;
      case 'proceedings-article':
          type = 'conference';
          break;
      case 'book-chapter':
      case 'book-section':
      case 'book-part':
          type = 'inbook';
          break;
      case 'journal-article':
          type = 'article';
          break;
      case 'report':
      case 'report-component':
      case 'report-series':
          type = 'techreport';
          break;
      case 'dissertation':
          type = 'phdthesis';
          break;
      case 'dataset':
      case 'database':
      case 'component':
      case 'standard':
      case 'grant':
      case 'posted-content':
      case 'reference-entry':
      case 'peer-review':
      case 'other':
          type = 'misc';
          break;
  }

  document.getElementById('reference-type').value = type;
  update_form();

  const fieldMappings = {
      title: work.title ? work.title[0] : '',
      year: work.published?.['date-parts']?.[0]?.[0] || '',
      journal: work['container-title'] ? work['container-title'][0] : '',
      volume: work.volume || '',
      number: work.issue || '',
      pages: work.page || '',
      month: work.published?.['date-parts']?.[0]?.[1] || '',
      note: work.note || '',
      publisher: work.publisher || '',
      school: work['institution'] ? work['institution'][0].name : '',
      institution: work['institution'] ? work['institution'][0].name : '',
      editor: work.editor ? work.editor.map(e => `${e.given} ${e.family}`).join(', ') : '',
      author: work.author ? work.author.map(a => `${a.given} ${a.family}`).join(', ') : ''
  };

  const fields = form_fields[type].required.concat(form_fields[type].optional);
  fields.forEach(field => {
      const fieldElement = document.getElementById(field);
      if (fieldElement && fieldMappings[field]) {
          fieldElement.value = fieldMappings[field];
      }
  });

  

  if (work.author && work.author.length > 0) {
    const authorsContainer = document.getElementById('authorsContainer');
    authorsContainer.innerHTML = ''; // this will remove the default author field
      work.author.forEach((author, index) => {
          if (index < 21) {
              add_author(`${author.given || ''} ${author.family || ''}`.trim());
          }
      });
  }
  update_form;
}
window.onload = () => {
  update_form();
  const referenceType = document.getElementById('reference-type');
  if (referenceType) {
    referenceType.value = referenceType.getAttribute('value');
    update_form();
  }
};

window.onload = update_form; // So that article fields are shown by default