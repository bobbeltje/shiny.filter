
F = {

    make_filter: function (data, el) {
        let container = F.make_container();
        container.append(F.make_list(data.values));
        el.replaceChildren(container);
    },

    make_list: function (items) {
        let ret = document.createElement('ul');
        for (var i = 0; i < items.length; i++) {
            let li = document.createElement('li');
            li.innerText = items[i];
            ret.append(li)
        }
        return ret;
    },

    make_container: function () {
        let x = document.createElement('div');
        x.className = 'filter-container';
        return x;
    },

    add_listeners: function (x, el) {
        el.addEventListener('click', e => {
            let target = e.target;
            if (target.tagName != 'LI') return;
            e.target.classList.toggle('selected');

            if (HTMLWidgets.shinyMode) F.update_server_input(x.elementId, el);
        })
    },

    update_server_input: function (id, el) {
        let arr = [];
        let items = el.querySelectorAll('li');
        for (var i = 0; i < items.length; i++) {
            if (items[i].classList.contains('selected')) arr.push(i);
        }

        Shiny.setInputValue(el.id + '_selected', arr);
    }

}
