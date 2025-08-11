         
async function updateStockTable() {
  

  
  const response = await fetch('/update_stock_info');
  const datas = await response.json();



         
  const tableBody = document.getElementById('stock-info-table-body');
  tableBody.innerHTML = '';
 
  

  var test=" stock-info-row-even"
  if (datas.length > 0) {
    datas.forEach((book, index) => {
       
        const rowClass = index % 2 === 0 ? "stock-info-row-even" : "";

        const row = `
            <tr class="${rowClass}">
                <td class="stock-info-cell">${book.name}</td>
                <td class="stock-info-cell">${book.author}</td>
                <td class="stock-info-cell">${book.stock}</td>
            </tr>
        `;
        tableBody.innerHTML += row;
    });
}  else {
    tableBody.innerHTML = `
        <tr>
            <td colspan="6">No games available for this company.</td>
        </tr>
    `;
  }
  
}

window.addEventListener('DOMContentLoaded', updateStockTable);



document.getElementById('add-book-form').addEventListener('submit', function(event) {
  event.preventDefault(); 
  
  const formData = new FormData(this);
  fetch('/add_book', {
      method: 'POST',
      body: formData,
  })
  .then(response => response.json())
  .then(data => {
      if (data.message) {
          alert("Kitap başarıyla eklendi!");
      } else if (data.error) {
          alert("Hata: " + data.error);
      }
  })
  .catch(error => {
      console.error('Error:', error);
  });
});


document.getElementById('delete-book-form').addEventListener('submit', function(event) {
  event.preventDefault(); 
  
  const formData = new FormData(this);
  fetch('/delete_book', {
      method: 'POST',
      body: formData,
  })
  .then(response => response.json())
  .then(data => {
      if (data.message) {
          alert("Kitap başarıyla silindi!");
      } else if (data.error) {
          alert("Hata: " + data.error);
      }
  })
  .catch(error => {
      console.error('Error:', error);
  });
});

const bookSearch = document.getElementById('book-search');
const bookSelect = document.getElementById('book-select');

const authorSearch=document.getElementById('author-search');
const authorSelect=document.getElementById('author-select');

const genreSearch=document.getElementById('genre-search');
const genreSelect=document.getElementById('genre-select');

authorSearch.addEventListener('input', () => {
    fetch(`/search/author?q=${authorSearch.value}`)
        .then(response => response.json())
        .then(data => {
            authorSelect.innerHTML = data.map(author => `<option value="${author.id}">Yazar Adı: ${author.name} </option>`).join('');
        });
});

genreSearch.addEventListener('input', () => {
    fetch(`/search/genre?q=${genreSearch.value}`)
        .then(response => response.json())
        .then(data => {
            genreSelect.innerHTML = data.map(genre => `<option value="${genre.id}">Tür Adı: ${genre.name} </option>`).join('');
        });
});


bookSearch.addEventListener('input', () => {
    fetch(`/search/book?q=${bookSearch.value}`)
        .then(response => response.json())
        .then(data => {
            bookSelect.innerHTML = data.map(book => `<option value="${book.kitap_id}">Kitap Adı: ${book.kitap_adi+", Baskı Tarihi:"+book.yili}  </option>`).join('');
        });
});

