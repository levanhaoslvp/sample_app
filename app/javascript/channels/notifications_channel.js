import consumer from "./consumer"

consumer.subscriptions.create("NotificationsChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        $(".notifications").prepend(data.html);
        this.update_counter(data.counter)
    },
    update_counter(counter) {
        $("#open_notification")
            .html(counter)
            .css({ top: '-10px' })
    }

});