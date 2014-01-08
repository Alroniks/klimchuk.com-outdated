# docpad.org

fs = require 'fs'
YAML = require 'yamljs'
moment = require 'moment'
richtypo = require 'richtypo'

docpadConfig = {
    templateData:
        cutTag: '<!-- cut -->'

        # will be read from lang file
        site: {}

        pageTitle: -> 
            if @document.title
                "#{@document.title} — #{@site.title}"
            else
                @site.title

    collections:
        posts: (database) ->
            database.findAllLive({relativeOutDirPath: 'all', unpublished: $exists: false}, [date:-1])

    # =================================
    # Environments
    # Language specific configuration
    # $ docpad run --env en
    # $ docpad generate --env en
    environments:
        en:
            documentsPaths: ['data/en']
            outPath: 'htdocs_en'
        ru:
            documentsPaths: ['data/ru']
            outPath: 'htdocs_ru'

    plugins:
        highlightjs:
            aliases:
                yaml: 'python'

    events:
        generateBefore: (opts) ->
            lang = @docpad.config.env
            @docpad.getConfig().templateData.site = (YAML.load "src/lang/#{lang}.yml")
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

# Export our DocPad Configuration
module.exports = docpadConfig