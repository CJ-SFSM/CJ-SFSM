
    function setActiveButton(activeId) {
        document.querySelectorAll('.filter-buttons button').forEach(button => {
            button.classList.remove('active');
        });
        document.getElementById(activeId).classList.add('active');
    }

    function filterAll() {
        setActiveButton('filterAll');
        const rows = document.querySelectorAll('#studentTable tr');
        rows.forEach(row => row.style.display = '');
    }

    function filterCDD() {
        setActiveButton('filterCDD');
        const rows = document.querySelectorAll('#studentTable tr');
        rows.forEach(row => {
            if (row.querySelector('.CDD')) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    function filterThese() {
        setActiveButton('filterThese');
        const rows = document.querySelectorAll('#studentTable tr');
        rows.forEach(row => {
            if (row.querySelector('.These')) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }

    function filterStage() {
        setActiveButton('filterStage');
        const rows = document.querySelectorAll('#studentTable tr');
        rows.forEach(row => {
            if (row.querySelector('.Stage')) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    }
