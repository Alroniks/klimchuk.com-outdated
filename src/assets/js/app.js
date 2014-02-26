$(function() {
    twitterFetcher.fetch('438683832993079296', '', 1, true, false, false, '', true, handleTweets, false);
    function handleTweets(tweets){
        $('#tweet').html(tweets[0]);
        $('.twitter').find('.loader').fadeOut(180, function(){
            $('.twitter').find('.tweet').fadeIn(280);    
        });
    }
});
