HTMLWidgets.widget({

  name: 'filter',

  type: 'output',

  factory: function (el, width, height) {

    var info = {};

    return {

      renderValue: function (x) {
        F.make_filter(x, el);
        F.add_listeners(x, el, info);
      },

      resize: function (width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
