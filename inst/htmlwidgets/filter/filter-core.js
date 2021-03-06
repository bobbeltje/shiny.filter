
F = {

    make_filter: function (x, el) {
        let container = F.make_container();
        container.append(F.make_list(x.values, x.options.selected));
        el.replaceChildren(container);
    },

    make_list: function (items, selected) {
        if (!selected) selected = [];
        if (typeof selected == 'number') selected = [selected];
        let ret = document.createElement('ul');
        for (var i = 0; i < items.length; i++) {
            let li = document.createElement('li');
            li.innerText = items[i];
            li.setAttribute('data-index', i);
            if (selected.includes(i + 1)) li.className = 'selected';
            ret.append(li)
        }
        return ret;
    },

    make_container: function () {
        let x = document.createElement('div');
        x.className = 'filter-container';
        return x;
    },

    add_listeners: function (x, el, info) {
        el.addEventListener('click', e => {

            let target = e.target;
            if (target.tagName != 'LI') return;

            F.update_dom_selection(el, e, info);
            if (HTMLWidgets.shinyMode) F.update_server_input(el);

            info.last = e.target.getAttribute('data-index');
        })
    },

    update_dom_selection: function (el, e, info) {
        let arr = el.querySelectorAll('li');
        if (e.shiftKey) {
            if (info.last) {
                let range = [parseInt(info.last), parseInt(e.target.getAttribute('data-index'))];
                range.sort((x, y) => x - y);
                for (var i = range[0]; i <= range[1]; i++) {
                    arr[i].classList.add('selected');
                }
            } else {
                e.target.classList.toggle('selected');
            }
        } else if (e.ctrlKey) {
            e.target.classList.toggle('selected');
        } else {
            for (var i = 0; i < arr.length; i++) {
                arr[i].classList.remove('selected');
            }
            e.target.classList.add('selected');
        }
    },

    update_server_input: function (el) {
        let arr = [];
        let items = el.querySelectorAll('li');
        for (var i = 0; i < items.length; i++) {
            if (items[i].classList.contains('selected')) arr.push(i + 1);
        }

        Shiny.setInputValue(el.id + '_selected', arr);
    }

}
