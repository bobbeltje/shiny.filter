
function make_filter(data, el) {
    let container = make_container();
    container.append(make_list(data.values));
    el.replaceChildren(container);
}

function make_list(items) {
    let ret = document.createElement('ul');
    for (var i = 0; i < items.length; i++) {
        let li = document.createElement('li');
        li.innerText = items[i];
        ret.append(li)
    }
    return ret;
}

function make_container() {
    let x = document.createElement('div');
    x.className = 'filter-container';
    return x;
}

function add_listeners(el) {
    el.addEventListener('click', e => {
        let target = e.target;
        if (target.tagName != 'LI') return;
        e.target.classList.toggle('selected');
    })
}
