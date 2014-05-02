fs = require 'fs'
YAML = require 'yamljs'
moment = require 'moment'
richtypo = require 'richtypo'

docpadConfig = {

    databaseCache: true,
    maxAge: false,

    templateData:
        cutTag: '<!-- cut -->'
        pageTitle: -> 
            if @document.title
                "#{@document.title} — #{@site.title}"
            else
                @site.title
        pageDescription: ->
            if @document.description
                "#{@document.description}"
            else
                @site.description
        pageKeywords: ->
            if @document.keywords
                "#{@document.keywords}"
            else
                @site.keywords
        cuttedContent: (content) ->            
            if @hasReadMore content
                cutIdx = content.search @cutTag
                content[0..cutIdx-1]
            else
                content
        hasReadMore: (content) ->
            content and ((content.search @cutTag) isnt -1)
        pubDate: (date) ->
            moment(date).format('LL')  # December 23 2013
        rt: (s) ->
            s and (richtypo.rich s)
        rtt: (s) ->
            s and (richtypo.title s)
        getTagUrl: (tag) ->
            doc = docpad.getFile({tag:tag})
            return doc?.get('url') or ''
        getPostsForTag: (tag) ->
            return @getCollection('posts').findAll(tags: $has: tag)
        translateTag: (tag) ->
            return @site.tags[tag.toLowerCase().replace(' ','')] or tag
        __: (s) ->
            s[@site.lang] or '__ALERT__'

    collections:
        posts: (database) ->
            database.findAllLive(
                {relativeOutDirPath: 'blog', isDraft: $ne: true}, 
                [date:-1]
            )
        clients: (database) ->
            database.findAllLive(
                {relativeOutDirPath: '4clients'},
                [pageOrder:1]
            )
        pages: (database) ->
            database.findAllLive(
                {inMenu: $exists: true}, 
                [pageOrder:1]
            )

    environments:
        en:
            documentsPaths: ['data/en']
            outPath: 'out/en'
            localeCode: 'en'
            templateData:
                site:
                    lang: 'en'
                    url: 'http://klimchuk.com'
                    title: 'Ivan Klimchuk'
                    description: 'Меня зовут Иван. Уже больше 5 лет работаю PHP-программистом в разных компаниях'
                    keywords: 'nothing'
                    author: 'Ivan Klimchuk <ivan@klimchuk.com>'
                    transLang: 'ru'
                    transUrl: 'http://klimchuk.by'
                    bezumkinru: 'Vasily Naumkin'
                    grinchikru: 'Victor Grinchik'
                    shevkocom: 'Valentin Shevko'
                    thrashme: 'Ryan Thrash'
                    markhamstracom: 'Mark Hamstra'
                    copyright: '&copy; 2010 &mdash; ' + (new Date()).getFullYear() + '. All right reserved.'
                    disqusShortname: 'klimchukcom'
                    tags:
                        closet: 'Closet'
                        modx: 'MODX'
                        personallife: 'Personal life'
                        development: 'Development'
                        cycling: 'Cycling'
        ru:
            documentsPaths: ['data/ru']
            outPath: 'out/ru'
            localeCode: 'ru'
            templateData:
                site:
                    lang: 'ru'
                    url: 'http://klimchuk.by'
                    title: 'Иван Климчук'
                    description: 'Меня зовут Иван. Уже больше 5 лет работаю PHP-программистом в разных компаниях'
                    keywords: 'nothing'
                    author: 'Иван Климчук <ivan@klimchuk.com>'
                    transLang: 'en'
                    transUrl: 'http://klimchuk.com'
                    bezumkinru: 'Василий Наумкин'
                    grinchikru: 'Виктор Гринчик'
                    shevkocom: 'Валентин Шевко'
                    thrashme: 'Райан Трэш'
                    markhamstracom: 'Марк Хамстра'
                    copyright: '&copy; 2010 &mdash; ' + (new Date()).getFullYear() + '. Все права защищены.'
                    disqusShortname: 'klimchukby'
                    tags:
                        closet: 'Чулан'
                        modx: 'MODX'
                        personallife: 'Личная жизнь'
                        development: 'Разработка'
                        cycling: 'Велосипед'
    plugins:
        highlightjs:
            aliases:
                yaml: 'python'
        jade:
            jadeOptions:
                pretty: true
        partials:
            partialsPath: process.cwd() + '/src/layouts/partials'
        tags:
            extension: '.html.jade'
            relativeDirPath: 'tags'
            injectDocumentHelper: (document) ->
                document.setMeta(
                    layout: 'innerpage'
                    data: "!=partial('tag')"
                )
            title: (tag) ->
                "Посты с тегом " + tag
        related:
            parentCollectionName: "posts"
        rss: 
            default:
                collection: 'posts'
                url: '/rss.xml'
        sitemap:
            cachetime: 600000 # one week approximately
            changefreq: 'weekly'
            priority: 0.5
            filePath: 'sitemap.xml'
    events:
        generateBefore: (opts) ->
            lang = @docpad.config.env
            moment.lang(lang)
            richtypo.lang(lang)
        serverExtended: (opts) ->
            {server} = opts
            docpad = @docpad
            latestConfig = docpad.getConfig()
            oldUrls = latestConfig.templateData.site.oldUrls or []
            newUrl = latestConfig.templateData.site.url

            server.use (req,res,next) ->
                if req.headers.host in oldUrls
                    res.redirect(newUrl+req.url, 301)
                else
                    next()
}

module.exports = docpadConfig
