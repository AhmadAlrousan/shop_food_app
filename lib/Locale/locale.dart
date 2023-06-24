
// Package imports:

import 'package:get/route_manager.dart';

import 'languages/ar_en_so.dart';
import 'languages/az_tt_zh-CN_sk_ml.dart';
import 'languages/bs_fr_gu_el.dart';
import 'languages/ca_hi_bg_ro.dart';
import 'languages/cy_rw_kn_et.dart';
import 'languages/de_ja_gd_sm_ht.dart';
import 'languages/es_lb_sv.dart';
import 'languages/eu_ko_si_mn.dart';
import 'languages/hu_tk_sl_mk_or.dart';
import 'languages/id_cs_te_lo.dart';
import 'languages/ig_ha_mg_xh_bn.dart';
import 'languages/jw_fa_mi_vi.dart';
import 'languages/ky_uk_pl_ru_mt.dart';
import 'languages/la_is_lt_mr_su.dart';
import 'languages/ne_ga_hmn_sq.dart';
import 'languages/no_af_lv_uz.dart';
import 'languages/pa_pt_be_my_ka.dart';
import 'languages/sn_zh_he_gl.dart';
import 'languages/sr_it_yi_km_co.dart';
import 'languages/st_ms_nl_kk_yo.dart';
import 'languages/th_da_sw.dart';
import 'languages/tr_ps_tg_hy.dart';
import 'languages/ur_ug_fi_ku_ta.dart';
import 'languages/zu_sd_ceb_tl_hr.dart';

class MyLocale implements Translations {

  @override
  Map<String, Map<String, String>> get keys => {
        "ar": ar,
        "en": en,"so": so,
        "es": es,"lb": lb,"sv": sv,"th": th,
        "da": da,"sw": sw, "af": af,"no": no,
        "lv": lv,"uz": uz,"id": id,"te": te,
        "cs": cs,"lo": lo,"jw": jw,"fa": fa,
        "vi": vi,"mi": mi,"sn": sn,"zh": zh,
        "he": he,"gl":gl,"eu": eu,
        "ko": ko,"si": si,"mn": mn,
        "ca": ca,"hi": hi,"ro": ro,"bg": bg,
        "el": el,"gu": gu,
        "fr": fr,"bs": bs,"ne": ne,"ga":ga,
        "hmn": hmn,"sq": sq,"cy":cy,"rw": rw,
        "kn": kn,"et": et,"zu": zu,"sd": sd,
        "ceb": ceb,"tl": tl,"hr": hr,"sr": sr,
        "it": it,"km": km, "yi": yi,"co": co,
        "my": my,"pa": pa,"ka": ka,"be": be,
        "pt": pt, "az": az, "ml": ml,"sk": sk,
        "tt": tt,"zh-CN": zh_cn,
        "ur": ur,"ku": ku,"ug": ug,"ta": ta,"fi": fi,
        "ky": ky,"uk": uk,"pl": pl,"ru": ru,
        "mt": mt,"de": de,"ja": ja,"gd": gd,
        "sm": sm,"ht": ht,"st": st,"ms": ms,"nl": nl,
        "kk": kk,"yo": yo,"ig": ig, "ha": ha,"mg": mg,
        "xh": xh,"bn": bn,
        "la": la,
        "is": is_,
        "lt": lt,
        "mr": mr,
        "su": su,
        "hu": hu,
        "tk": tk,
        "sl": sl,
        "mk": mk,
        "or": or,
        "tr": tr,
        "ps": ps,
        "tg": tg,
        "hy": hy

  };
}