$(function(){

	function fetchSessionTime() {
        $.ajax({
            url: '/api/session-time',
            method: 'GET',
            success: function(data) {
                var remainingTime = data.remainingTime;
                $('#timer').text(formatTime(remainingTime));
				if(remainingTime <=0) {
					goLogout();
				}
            },
            error: function() {
                $('#timer').text('Loading...');
            }
        });
    }
	
	function resetSession() {
        $.ajax({
            url: '/api/reset-session',
            method: 'GET',
            success: function() {
                // Optionally handle success
            },
            error: function() {
                // Optionally handle error
            }
        });
    }
	
	function goLogout() {
		$.ajax({
			url: '/api/logout',
			method: 'GET',
			success: function() {},
		});
	}

    function formatTime(seconds) {
        var minutes = Math.floor(seconds / 60);
        var secs = seconds % 60;
        return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
    }

    $(document).ready(function() {
        fetchSessionTime(); // 시스템 호출
		resetSession(); // 페이지 변경 시 남은 시간 초기화
        setInterval(fetchSessionTime, 1000); // 매초마다 호출	
			
		// 사용자가 연장 버튼 클릭 시 남은 시간 초기화
        $(".login-time-reset").on('click', function() {
            resetSession();
        });
		
    });
	
});