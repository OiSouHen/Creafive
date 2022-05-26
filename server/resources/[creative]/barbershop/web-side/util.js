$(document).ready(() => {
    let bShiftPress = false;

    $(".menu-item").click(function() {
        $(".menu-item").removeClass("active");
        $(this).addClass("active");
        $(".option-separator").removeClass("active");
        $(`.${$(this).attr('data-ref')}`).addClass("active");
    });

    document.onkeyup = function(data) {
        if (data.which == 16) {
            bShiftPress = false;
        }
    };

    document.onkeydown = function(data) {
        if (data.which == 16) {
            bShiftPress = true;
        }

        if (data.which == 65) {
            $.post('http://barbershop/rotate', JSON.stringify("right"));
        }

        if (data.which == 68) {
            $.post('http://barbershop/rotate', JSON.stringify("left"));
        }
    };

    updateSlider();

    $('.fa-angle-left').click(function(e) {
        e.preventDefault();
        const valueCap = bShiftPress ? 10 : 1;
        $(this).parent().find('input[type=range]').val(Number($(this).parent().find('input[type=range]').val()) - valueCap);
        updateSlider();
        arrowClick();
    });

    $('.fa-angle-right').click(function(e) {
        e.preventDefault();
        const valueCap = bShiftPress ? 10 : 1;
        $(this).parent().find('input[type=range]').val(Number($(this).parent().find('input[type=range]').val()) + valueCap);
        updateSlider();
        arrowClick();
    });



    function arrowClick() {
        $.post('http://barbershop/updateSkin', JSON.stringify({
            value: false,
            fathers: $('#fathers').val(),
            mothers: $('#mothers').val(),
            kinship: $('#kinship').val(),
            eyecolor: $('#eyecolor').val(),
            skincolor: $('#skincolor').val(),
            acne: $('#acne').val(),
            stains: $('#stains').val(),
            freckles: $('#freckles').val(),
            aging: $('#aging').val(),
            hair: $('#hair').val(),
            haircolor: $('#haircolor').val(),
            haircolor2: $('#haircolor2').val(),
            makeup: $('#makeup').val(),
            makeupintensity: $('#makeupintensity').val(),
            makeupcolor: $('#makeupcolor').val(),
            lipstick: $('#lipstick').val(),
            lipstickintensity: $('#lipstickintensity').val(),
            lipstickcolor: $('#lipstickcolor').val(),
            eyebrow: $('#eyebrow').val(),
            eyebrowintensity: $('#eyebrowintensity').val(),
            eyebrowcolor: $('#eyebrowcolor').val(),
            beard: $('#beard').val(),
            beardintentisy: $('#beardintentisy').val(),
            beardcolor: $('#beardcolor').val(),
            blush: $('#blush').val(),
            blushintentisy: $('#blushintentisy').val(),
            blushcolor: $('#blushcolor').val(),
            face00: $('#face00').val(),
            face01: $('#face01').val(),
            face04: $('#face04').val(),
            face06: $('#face06').val(),
            face08: $('#face08').val(),
            face09: $('#face09').val(),
            face10: $('#face10').val(),
            face12: $('#face12').val(),
            face13: $('#face13').val(),
            face14: $('#face14').val(),
            face15: $('#face15').val(),
            face16: $('#face16').val(),
            face17: $('#face17').val(),
            face19: $('#face19').val()
        }));
    }

    function updateSlider() {
        $('input').each(function() {
            var max = $(this).attr('max'),
                val = $(this).val();
            $(this).parent().parent().find('label').find('p:last-child').text(val + ' / ' + max);
        });

        for (let e of document.querySelectorAll('input[type="range"].slider-progress')) {
            e.style.setProperty('--value', e.value);
            e.style.setProperty('--min', e.min == '' ? '0' : e.min);
            e.style.setProperty('--max', e.max == '' ? '100' : e.max);
            e.addEventListener('input', () => e.style.setProperty('--value', e.value));
        }
    }
});