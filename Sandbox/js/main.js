window.addEventListener('load', function () {
  // IIFE - Immediately-Invoked Function Expression
  // to avoid polluting the global namespace
  (function () {
    // The body has two data attributes (nav, default) that declaratively indicate
    // the markdown files that holds the navigation and the default page contents.
    const $body = document.body;
    const navSrc = $body.dataset.nav;
    const defaultSrc = $body.dataset.default;
    const $location = window.location;
    let $all = {
      nav: {},
      default: {}
    };

    fetchMd(navSrc)
      .then(capture($all, 'nav'))
      .then(createElement('nav'))
      .then(function (el) {
        console.log($all.nav);
        if ($all.nav) {
          var __fm = $all.nav.frontMatter;
          console.log(__fm);
          if (__fm) {
            el.classList.add($all.nav.position);
            var links = el.getElementsByTagName('a');
            for (var i = 0; i < links.length; i++) {
              if (__fm.target === 'nav') {
                // then there is a secondary set of navs to be loaded
                var path = links[i].href.replace('#', '');
                fetchMd(path)
                  .then(createElement('nav'))
                  .then(appendToBody())
                  .then(function (e) {
                    e.dataset.parentNav = path.replace($location.origin, '');
                  });
                links[i].addEventListener('click', showSubNav);
              } else {
                links[i].addEventListener('click', doNavClick);
              }
            }
          }
        }
        $body.appendChild(el);
      });
    fetchMd(defaultSrc)
      .then(capture($all, 'default'))
      .then(createElement('main'))
      .then(function (el) {
        $body.appendChild(el);
      });
    console.log($all);

    /* ************ Hoisted Functions ************** */
    function showSubNav(evt) {
      var _main = $body.querySelector('main');
      var _path = this.href.replace('#', '');
      fetchMd(_path)
        .then(function (content) {
          _main.innerHTML = content.markup;
        });
      evt.preventDefault();
    }
    function doNavClick(evt) {
      var _main = $body.querySelector('main');
      var _path = this.href.replace('#', '');
      fetchMd(_path)
        .then(function (content) {
          _main.innerHTML = content.markup;
        });
      evt.preventDefault();
    }
    function capture(obj, prop) {
      return function (content) {
        obj[prop] = content;
        return content;
      }
    }
    function createElement(tagName) {
      return function (content) {
        var el = document.createElement(tagName);
        if (content) {
          el.innerHTML = content.markup;
        }
        return el;
      }
    }
    function appendToBody() {
      return function (el) {
        $body.appendChild(el);
        return el;
      }
    }

    /**
     * fetchMd will fetch and parse a markdown file
     * 
     * @param {string} path
     * @returns A promise that is passed an object with two properties: frontMatter, markup
     */
    function fetchMd(path) {
      // Custom Markdown Renderings
      var renderer = new marked.Renderer();
      renderer.heading = customHeadingRenderer;
      renderer.link = customLinkRenderer;
      renderer.image = customImageRenderer;

      return fetch(path, { method: 'GET', cache: 'reload' })
        .then(status)
        .then(responseToText)
        .then(markdownToFrontMatterMarkup)
        .catch(consoleLogFetchError);

      /* Fetch infrastructure */
      function status(response) {
        if (response.status >= 200 && response.status < 300) {
          return Promise.resolve(response)
        } else {
          return Promise.reject(new Error(response.statusText))
        }
      }

      function responseToText(response) { return response.text(); }

      function markdownToFrontMatterMarkup(text) {
        var md = text.split(/\r?\n/); // \r is optional to work both locally with lite-server and in production
        var fm = [];
        if (md.indexOf('---') === 0) {
          fm = md.splice(0, md.indexOf('---', 1));
          md = md.splice(1, md.length - 1);
        }
        var fms = fm.join('\n');
        var mds = md.join('\n');
        var content = {
          frontMatter: YAML.parse(fms),
          markup: marked.parse(mds, { renderer: renderer })
        }
        return content;
      }

      function consoleLogFetchError(response) {
        // right now, just console-logging the error
        if (response.headers) {
          console.log('<!--  Fetch Error:');
          console.log(response.headers.get('Content-Type'));
          console.log(response.headers.get('Date'));

          console.log(response.status);
          console.log(response.statusText);
          console.log(response.type);
          console.log(response.url);
          console.log('... end Fetch Error-->');
        } else {
          console.log('<!-- Other error:');
          console.log(response);
          console.log('... end Fetch Error-->');
        }
      }

      /* Custom Markdown Renderings */
      function customHeadingRenderer(text, level) {
        var escapedText = text.toLowerCase().replace(/[^\w]+/g, '-');

        return '<h' + level + '><a name="' +
          escapedText +
          '" class="anchor" href="#' +
          escapedText +
          '"><span class="header-link"></span></a>' +
          text + '</h' + level + '>';
      };

      function customLinkRenderer(href, title, text) { // string, string, string
        if (!href.startsWith('http')) {
          href = "#" + href;
          // href = "#" + MdContent.routePath.replace(':mdFile*', href);
          // href = href.replace('//', '/');
        }
        if (this.options.sanitize) {
          try {
            var prot = decodeURIComponent(unescape(href))
              .replace(/[^\w:]/g, '')
              .toLowerCase();
          } catch (e) {
            return '';
          }
          if (prot.indexOf('javascript:') === 0 || prot.indexOf('vbscript:') === 0) {
            return '';
          }
        }
        var out = '<a href="' + href + '"';
        if (title) {
          out += ' title="' + title + '"';
        }
        out += '>' + text + '</a>';
        return out;
      }

      function customImageRenderer(href, title, text) { // string, string, string
        if (!href.startsWith('http')) {
          href = 'posts/' + href;
          href = href.replace('//', '/');
        }
        var out = '<img src="' + href + '" alt="' + text + '"';
        if (title) {
          out += ' title="' + title + '"';
        }
        out += this.options.xhtml ? '/>' : '>';
        return out;
      }
    };
  })();
});