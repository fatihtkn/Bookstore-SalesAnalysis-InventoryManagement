
fetch('/get_sales_data')
  .then(response => response.json())
  .then(data => {
   
    var options = {
      chart: {
        type: 'line', 
        height: 600
      },
      series: data.series, 
      xaxis: {
        categories: data.categories 
      },
      colors: ['#FF5733', '#33FF57', '#3357FF','#EB00E2','#00EBE9','#EBEB00','#A300F0'], 
      title: {
        text: 'Platforma Göre Satışlar',
        align: 'center',
        style: {
          fontSize: '20px',
          fontWeight: 'bold',
          color: '#333'
        }
      }
    };

    
    var chart = new ApexCharts(document.querySelector("#platform-sales-chart"), options);
    chart.render();
  })
  .catch(error => console.error('Veri çekme hatası:', error));
