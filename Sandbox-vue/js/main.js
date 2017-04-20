// A Vue component that represents a Markable Item
Vue.component('weighted-item', {
    template: 
    `<div>
      <input type="text" name="itemName" placeholder="Item Name" v-model="theName" />
      <input type="number" name="weight" min="1" max="100" v-model="theWeight" /> ?
    </div>`,
    props: ['theName', 'theWeight']
});



// create the core/main Vue object
new Vue({
    // selector for the element (template) that "hosts" the root Vue component
    el: '#app',
    // Data that can be referenced/used in the template
    data: {
        greeting: 'Welcome to your Vue.js app!',
        docsURL: 'http://vuejs.org/guide/',
        gitterURL: 'https://gitter.im/vuejs/vue',
        forumURL: 'http://forum.vuejs.org/'
    },
    // Methods that can be referenced/used in the template
    methods: {
        humanizeURL: function (url) {
            return url
            .replace(/^https?:\/\//, '')
            .replace(/\/$/, '')
        }
    }
});
